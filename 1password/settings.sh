#!/bin/sh

chart_name=1password/connect
arguments="--set-file connect.credentials=./$3/1password_creds.json --set operator.token.value=$(cat ./$3/1password_token.txt)"