#!/usr/bin/env sh

# This script formats SQL including dbt templates using the `sqlfmt` command
# from https://sqlfmt.com/ It formats the output properly so it reads from
# standard input and print to standard output without any extra lines

/opt/homebrew/Caskroom/miniconda/base/envs/tardis-new/bin/sqlfmt --quiet 2>/dev/null - | sed '${/^$/d;}'  # try with to remove only if the last line is empty  '$d'
