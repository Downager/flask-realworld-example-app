#!/bin/bash
set -e

if [[ -d migrations/versions/ ]]
then
    flask db migrate
    flask db upgrade
else
    flask db init
    flask db migrate
    flask db upgrade
fi