#!/usr/bin/env sh

################################################################################
# Store this file as .git/hooks/commit-msg in your repository in order to
# enforce checking for proper commit message format before actual commits. You
# may need to make the script executable by 'chmod +x .git/hooks/commit-msg'.
################################################################################

# Include any branches for which you wish to disable this script
if [ -z "$BRANCHES_TO_SKIP" ]; then
  BRANCHES_TO_SKIP=(master develop staging test)
fi
# Get the current branch name and check if it is excluded
BRANCH_NAME=$(git symbolic-ref --short HEAD)
BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")
# Trim it down to get the parts we're interested in
TRIMMED=$(echo $BRANCH_NAME | sed -e 's:^\([^-]*-[^-]*\)-.*:\1:' -e \
    'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/')
# If it isn't excluded, preprend the trimmed branch identifier to the given message
if [ -n "$BRANCH_NAME" ] &&  ! [[ $BRANCH_EXCLUDED -eq 1 ]]; then
  sed -i.bak -e "1s/^/$TRIMMED /" $1
fi