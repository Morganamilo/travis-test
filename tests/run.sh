#!/usr/bin/sh

set -e

make test

./tests/install_aurweb-test.sh

aurweb-test&
sleep 1

./tests/test_connection.sh


