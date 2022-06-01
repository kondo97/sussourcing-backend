#!/bin/sh -x

RAILS_ROOT=`(cd \`dirname $0\`/../; pwd)`
RAILS_ENV=$1 # development or test

TABLE_OPTIONS='ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC'

cd $RAILS_ROOT || exit
bundle exec ridgepole -c config/database.yml -f db/schema.rb --apply --table-options="$TABLE_OPTIONS" --env=development --spec-name primary $@
bundle exec ridgepole -c config/database.yml -f db/schema.rb --apply --table-options="$TABLE_OPTIONS" --env=test --spec-name primary $@

bundle exec annotate --models

if [ "$RAILS_ENV" == "test" ]; then
    bundle exec rake parallel:create
    bundle exec rake parallel:prepare
fi