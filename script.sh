#!/bin/bash

#get appcode
appcode=$1

#set variables
lp_prefix="APP_MUV0_"
lp_suffix_user="_USER"
lp_suffix_viewer="_VIEWER"
lp_user=$(echo $lp_prefix$appcode$lp_suffix_user)
lp_viewer=$(echo $lp_prefix$appcode$lp_suffix_viewer)
pl_suffix="_pool: 10"
pool=$(echo $appcode$pl_suffix)
new_branch=$(echo onboarding-$appcode)

#print in console
echo "Received appcode:" $appcode
echo "LDAP DEV/QA/UAT:" $lp_user
echo "LDAP PROD:" $lp_viewer
echo "Pool:" $pool

# clean up temp folder before git clone
rm -rf temp

# git clone
mkdir temp
echo "git clone"
git clone https://github.com/bmoon4/ldap-test.git temp
cd temp

# git checkout -b onboarding-$appcode
echo "git checkout -b"
git checkout -b $new_branch

#add new change
echo "add changes"
echo "  - "$lp_user >> configs/dev/ldap.yaml
echo "  - "$lp_user >> configs/qa/ldap.yaml
echo "  - "$lp_user >> configs/uat/ldap.yaml
echo "  - "$lp_viewer >> configs/prod/ldap.yaml

echo "git add ."
git add .

# git commit
echo "git commit"
git commit -m "[ldap] new appcode onboarding"

# # git push
git push -u --set-upstream origin $new_branch

# clean up temp folder
rm -rf temp

exit 0
