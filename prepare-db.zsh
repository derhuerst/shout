#!/usr/bin/env zsh

echo "chrome push key please"
read KEY

echo "\
set g:berlin '{\"k\":\"4cca53e7-e9ef-4c16-bdfb-934ed4d20c6d\",\"l\":false}'\n
set u:berlin:abcdefg '{\"s\":\"chrome\",\"t\":\"$KEY\"}'\n
set m:berlin:abcdefgh '{\"d\":1443118824661,\"b\":\"test\"}'\n
exit\n" | redis-cli
