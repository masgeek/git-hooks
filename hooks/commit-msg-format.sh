#!/usr/bin/env sh

################################################################################
# Store this file as .git/hooks/commit-msg in your repository in order to
# enforce checking for proper commit message format before actual commits. You
# may need to make the script executable by 'chmod +x .git/hooks/commit-msg'.
################################################################################

#
# Automatically adds branch name and branch description to every commit message.
# Modified from the stackoverflow answer here: http://stackoverflow.com/a/11524807/151445
#

# Succeed on all merge messages, as evidenced by MERGE_MSG existing
[ -f $GIT_DIR/MERGE_MSG ] && exit 0

# Get branch name and description
NAME=$(git branch | grep '*' | sed 's/* //')
DESCRIPTION=$(git config branch."$NAME".description)

# Don't apply this logic if we are in a 'detached head' state (rebasing, read-only history, etc)
# newlines below may need echo -e "\n\n: (etc.)"
if [ "$NAME" != "(no branch)" ]; then
	# Append branch name and optional description to COMMIT_MSG
	# For info on parameters to githooks, run: man githooks
	echo "\n\n: $NAME $DESCRIPTION" >> "$1"
fi