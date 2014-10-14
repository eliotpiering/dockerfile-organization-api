#!/bin/bash

cd /var/www/organization_api/current;
bundle install;
rake db:migrate
rails s -b 0.0.0.0;

