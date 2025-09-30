#!/usr/bin/env sh

CURRENT_VALUE=$(ddcutil getvcp 10 --bus=$BUS --skip-ddc-checks)
CURRENT_VALUE=$(echo $CURRENT_VALUE | grep --extended-regexp --only-matching "current value = {,10}[0-9]{1,3}")
CURRENT_VALUE=$(echo $CURRENT_VALUE | grep --extended-regexp --only-matching "[0-9]{1,3}$")

STEP=$(($CURRENT_VALUE % 10))
NEW_VALUE=$(($CURRENT_VALUE - 10 - STEP))
VALUE=$(($NEW_VALUE > 0 ? $NEW_VALUE : 0))
ddcutil setvcp 10 $VALUE --bus=$BUS --skip-ddc-checks
