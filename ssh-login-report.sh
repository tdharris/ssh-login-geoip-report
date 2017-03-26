#!/bin/bash
list="/tmp/iplist.txt"

# check geoiplookup dependecy
geoipdep=true;
which geoiplookup &>/dev/null;
if [ $? -ne 0 ]; then 
  geoipdep=false; 
  echo -e "\nGeoIP undetected. Will skip sshfilter reports...\n\n\tConsider limiting your ssh logins using GeoIP: https://www.axllent.org/docs/view/ssh-geoip/.\n\tNote: Add logging statements from sshfilter.sh to auth facility (logger -p auth.notice) so logging statements are added to /var/log/auth.log. See sshfilter.sh as an example."; 
fi

# sshd - failures
if $geoipdep; then
  echo -e "\nBlocked auth attemps (failed sshfilter):"
  zgrep sshd /var/log/auth.log* | grep logger | grep DENY | awk '{ print $10 }' | sort -u > "$list"
  cat "$list" | sort | uniq | xargs -n 1 geoiplookup { } | sort | uniq -c | sort -nr
fi

# sshd - failed logins
echo -e "\nAllowed to auth (passed sshfilter), but failed login:"
zgrep sshd /var/log/auth.log* | grep rhost | sed -re 's/.*rhost=([^ ]+).*/\1/' | sort -u > "$list"
cat "$list" | sort | uniq | xargs -n 1 geoiplookup { } | sort | uniq -c | sort -nr

# sshd - permitted login attempt (passed geo-check)
if $geoipdep; then
  echo -e "\nPermitted auth attempts (passed sshfilter):"
  zgrep sshd /var/log/auth.log* | grep logger | grep ALLOW | awk '{ print $10 }' | sort -u > "$list"
  cat "$list" | sort | uniq | xargs -n 1 geoiplookup { } | sort | uniq -c | sort -nr
fi

# sshd - accepted logins
echo -e "\nAccepted logins:"
zgrep sshd /var/log/auth.log* | grep Accepted > "$list"
cat "$list" | awk '{ print $11 }' | sort | uniq | xargs -n 1 geoiplookup { } | sort | uniq -c | sort -nr 
echo
cat "$list"

# cleanup
rm -f "$list"
