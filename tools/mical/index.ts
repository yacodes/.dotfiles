#!/usr/bin/env node

import glob from "glob";
import fs from "node:fs";
import { argv, stdout } from "node:process";

/**
 * Represent a line, parsed from iCalendar content string.
 */
export type ICalLine = string;

/**
 * Split `.ical` file string into an array of strings.
 * Does not process them in any way, except filtering empty lines.
 *
 * @param str - iCalendar content string.
 * @returns Array of iCalendar fields and values as strings.
 */
const toLines = (str: string): ICalLine[] =>
  str
    .split(/\n(?!\s)/)
    .filter(Boolean)
    .map((line) => line.trim());

/**
 * Get values from iCalendar lines until first `BEGIN:VEVENT` is met.
 *
 * @param lines - iCalendar array of keys and values.
 * @returns All keys and values until first `BEGIN:VEVENT` line.
 */
const getCalendarBeginning = (lines: ICalLine[]): ICalLine[] => {
  const result: string[] = [];
  for (const line of lines) {
    if (line === "BEGIN:VEVENT") return result;
    result.push(line);
  }
  return result;
};

/**
 * Get values from iCalendar lines between first `BEGIN:VEVENT` and first `END:VEVENT`.
 *
 * @param lines - iCalendar array of keys and values.
 * @returns All keys and values between first `BEGIN:VEVENT` line and first `END:VEVENT`.
 *
 * @todo
 * 1. Respect consequential `BEGIN:VEVENT` and `END:VEVENT` as well. Not only the first one.
 */
const getEvent = (lines: ICalLine[]): ICalLine[] => {
  const result: string[] = [];
  let isEvent = false;
  for (const line of lines) {
    if (line === "BEGIN:VEVENT") isEvent = true;
    if (isEvent) result.push(line);
    if (line === "END:VEVENT") return result;
  }
  return result;
};

const [filesGlob] = argv.slice(2);
if (!filesGlob) {
  console.error(
    "No files for merging found. Please provide a glob to the ical files as a 1st argument. Example: mical ./events/*.ics > result.ics"
  );
  process.exit();
}

const files = glob
  .sync(filesGlob)
  .map((filename: string): string =>
    fs.readFileSync(filename, { encoding: "utf8" })
  )
  .map(toLines);

stdout.write(
  files
    .map(getEvent)
    .reduce(
      (calendar: string[], event: string[]): string[] => calendar.concat(event),
      getCalendarBeginning(files[0])
    )
    .concat(["END:VCALENDAR"])
    .join("\n")
);
