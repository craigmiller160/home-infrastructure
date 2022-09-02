#!/bin/sh

# TODO delete this file
arguments="--set-file connect.connect.credentials=./$2/1password_creds.json --set connect.operator.token.value=$(cat ./$2/1password_token.txt)"