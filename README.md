# ssh-login-report

This was created with the intent of showing a GeoIP ssh-login report. Includes the following sections:
- Blocked auth attemps (failed sshfilter)
- Allowed to auth (passed sshfilter), but failed login
- Permitted auth attempts (passed sshfilter)
- Accepted logins

Inspired by the following example of how to limit ssh logins using GeoIP:
https://www.axllent.org/docs/view/ssh-geoip/

Here is a small sample of what the script may output. For a more detailed example report, please refer to [example-ssh-login-report.log](example-ssh-login-report.log).
```
Blocked auth attemps (failed sshfilter):
    625 GeoIP Country Edition: CN, China
    367 GeoIP Country Edition: VN, Vietnam
    ...
    
Allowed to auth (passed sshfilter), but failed login:
    1 GeoIP Country Edition: IP Address not found

Permitted auth attempts (passed sshfilter):
    3 GeoIP Country Edition: US, United States
    2 GeoIP Country Edition: IP Address not found
      
Accepted logins:
    3 GeoIP Country Edition: IP Address not found
    2 GeoIP Country Edition: US, United States
      
/var/log/auth.log:Mar 26 11:16:18 <serverName> sshd[5815]: Accepted password for <userid> from <ip/host> port 59351 ssh2
/var/log/auth.log:Mar 26 11:54:05 <serverName> sshd[22792]: Accepted password for <userid> from <ip/host> port 54296 ssh2
...
```
