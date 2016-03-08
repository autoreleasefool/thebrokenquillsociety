#!/bin/bash

#################################################
#                                               #
#    Use the following two commands to make a   #
#      backup of the production database.       #
#  The first will set a variable to the current #
#  date to use as the file name and the second  #
#     will export the database to the file.     #
#                                               #
#################################################

export current_date=`date +"%Y%m%d_%H%M%N"`
pg_dump -F c -v -U rails -h localhost thebrokenquillsociety_production -f ~rails/thebrokenquillsociety/backup/${current_date}.sql
