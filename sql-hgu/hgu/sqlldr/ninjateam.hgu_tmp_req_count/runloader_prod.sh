#!/usr/bin/env bash

if [[ $# != 1 ]]
then
	echo "Please provide one argument; the file to load.";
	exit;
fi
eval sqlldr ninjateam/ninjateam@ninjaprod1 -data="$1" -control=hgu_tmp_req_count.ctl -bad=hgu_tmp_req_count.bad -discard=hgu_tmp_req_count.dsc -errors=256000
