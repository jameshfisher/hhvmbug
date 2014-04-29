#!/bin/bash

set -x
set -u
set -e

vagrant up

curl -u testuser:testpassword http://localhost:5424/ > /tmp/php.out
curl -u testuser:testpassword http://localhost:5425/ > /tmp/hhvm.out

colordiff /tmp/php.out /tmp/hhvm.out
