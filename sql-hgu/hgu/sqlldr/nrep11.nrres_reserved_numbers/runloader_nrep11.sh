#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninja/ninja2004@nrep11 -data="$1" -control=nrres_reserved_numbers.ctl -log=nrres_reserved_numbers.log -bad=nrres_reserved_numbers.bad


