#!/bin/sh

chart_name=./1password
arguments="--set-file connect.connect.credentials=./$3/1password_creds.json --set connect.operator.token.value=$(cat ./$3/1password_token.txt)"