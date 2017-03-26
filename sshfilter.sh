#!/bin/bash
# note: https://www.axllent.org/docs/view/ssh-geoip/

# UPPERCASE space-separated country codes to ACCEPT
ALLOW_COUNTRIES="US CA"

if [ $# -ne 1 ]; then
  echo "Usage:  `basename $0` <ip>" 1>&2
  exit 0 # return true in case of config issue
fi

COUNTRY=`/usr/bin/geoiplookup $1 | awk -F ": " '{ print $2 }' | awk -F "," '{ print $1 }' | head -n 1`

[[ $COUNTRY = "IP Address not found" || $ALLOW_COUNTRIES =~ $COUNTRY ]] && RESPONSE="ALLOW" || RESPONSE="DENY"

if [ $RESPONSE = "ALLOW" ]
then
  logger -p auth.notice "$RESPONSE sshd connection from $1 ($COUNTRY)"
  exit 0
else
  logger -p auth.warn "$RESPONSE sshd connection from $1 ($COUNTRY)"
  exit 1
fi
