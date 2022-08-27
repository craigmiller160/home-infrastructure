#!/bin/sh

chart_name=1password/operator
arguments="--set operator.token.value=$(cat ./$3/1password_token.txt)"