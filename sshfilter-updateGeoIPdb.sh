#!/bin/bash

cd /tmp
wget -q https://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
wget -q https://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz
if [[ -f GeoIP.dat.gz && -f GeoIPv6.dat.gz ]]
then
    gzip -d GeoIP.dat.gz GeoIPv6.dat.gz
    #rm -f /usr/share/GeoIP/GeoIP.dat /usr/share/GeoIP/GeoIPv6.dat
    mv -f GeoIP.dat /usr/share/GeoIP/GeoIP.dat
    mv -f GeoIPv6.dat /usr/share/GeoIP/GeoIPv6.dat
else
    echo "The GeoIP library could not be downloaded and updated"
fi
