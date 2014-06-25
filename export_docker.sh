#!/bin/bash
rm -rf dockerenv
mkdir dockerenv && cd dockerenv

# export last running docker container and untar it here
docker export `docker ps -l -q` | tar x

# mv var out of the way since it is reserved in sandstorm
# parts of var_original will be copied in run_grain.sh
mv var var_original
mkdir var

rm -rf tmp
mkdir tmp

# clean up etc/service
rm -rf etc/service/*/supervise

# fix run/lock
cd var_original
rm lock run
rm -f ../run/crond.reboot
cp -r ../run .
ln -s run/lock lock
cd ..


# cp sandstorm-httpGet to /bin and move config into place
cd opt
cp app/sandstorm/bin/* ../bin
cp app/config.php-sandstorm app/config.php
cd ../..

# copy local version of my_init over
cp my_init dockerenv/sbin/
