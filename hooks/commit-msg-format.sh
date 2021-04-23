#!/usr/bin/env sh

################################################################################
# Store this file as .git/hooks/commit-msg in your repository in order to
# enforce checking for proper commit message format before actual commits. You
# may need to make the script executable by 'chmod +x .git/hooks/commit-msg'.
################################################################################

path=$1
echo path is $path

a=$(cat $path)
echo commit message is
echo $a
if [[ "$a" =~ "hello world" ]];then
  echo commit format test passed
  exit 0
else
  echo commit format test failed
  exit 1
fi