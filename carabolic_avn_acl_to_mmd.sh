#!/usr/bin/env bash

IFS=$'\n'
for entry in `avn service acl-list --project hellofresh-live kafka-live | grep -e '\spublic.'`; do
    acl=`echo $entry | awk -F ' ' '{print $1}'`
    service=`echo $entry | awk -F ' ' '{print $2}'
    topic=`echo $entry | awk -F ' ' '{print $3}'`
    # permission=`echo $entry | awk -F ' ' '{print $4}'`
    # echo "$service $topic $permission"
    echo "$service $topic"
done
