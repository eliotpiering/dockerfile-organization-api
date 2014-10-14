#!/bin/bash

cd /home/app/fullConnectAPI;
bundle install;
rake db:migrate
rails s -b 0.0.0.0;

