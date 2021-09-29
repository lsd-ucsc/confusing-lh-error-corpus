#!/usr/bin/env bash

# Dependencies
#   GIT - https://git-scm.com/
#   ENTR - https://eradman.com/entrproject/ - Rebuild project if sources change 

git ls-files | entr -c bash -c "
set -x
FILES=\$(find lib -name '*.hs') # list haskell files
WTFS=\$(     grep    '^\s*-- .*WTF.*' \$FILES) # list WTFs
WTF_FILES=\$(grep -l '^\s*-- .*WTF.*' \$FILES) # list WTF files
WTF_RET=\$? # save the fact of having found any WTFs
git add --no-all . # add all files
git commit -m \"Autocommit \$WTFS\" # commit with a full record of WTFs
if [[ \$? == 0 ]]; then # if any WTFs were found ..
    sed '/^\s*-- .*WTF.*/d' -i \$FILES # remove the WTFs from the files
fi
"
