#!/bin/sh

mysql -h127.0.0.1 -uroot -p12345 -e'alter user "uniesi"@"%" identified with mysql_native_password by "12345"'
