#!/usr/bin/env bash

export INDEX="smartmeter";
export URL="http://localhost:9200/";
export OLD_DIR=`pwd`;
export WRK_DIR=`dirname $0`;

cd $WRK_DIR;

#delete index
curl -XDELETE "$URL""$INDEX"

#check if it is deleted
curl -XGET $URL"_cat/indices?v"

#create/update template for index
shopt -s nullglob
for f in *.json; do
    echo $f
    cat $f | curl -XPUT --data-binary @- $URL"_template/"$INDEX
done;

cd $OLD_DIR;
