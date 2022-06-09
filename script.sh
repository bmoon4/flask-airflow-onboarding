#!/bin/bash

#get appcode
appcode=$1
email=$2

echo "your appcode: " $appcode
echo "your email: " $email
#set variables
lp_prefix="APP_MUV0_"
lp_suffix_user="_USER"
lp_suffix_viewer="_VIEWER"
lp_user=$(echo $lp_prefix$appcode$lp_suffix_user)
lp_viewer=$(echo $lp_prefix$appcode$lp_suffix_viewer)
pl_suffix="_pool: 10"
pool=$(echo $appcode$pl_suffix)
new_branch=$(echo onboarding-$appcode-$email)

#print in console
echo "Received appcode:" $appcode
echo "LDAP DEV/QA/UAT:" $lp_user
echo "LDAP PROD:" $lp_viewer
echo "Pool:" $pool

# clean up temp folder before git clone
rm -rf temp

# git setup
git config --global user.email "bkmoon0702@gmail.com"

echo "############################# LDAP setup ###############################"


# git clone
mkdir temp
echo "git clone"
git clone https://XXXXX@github.com/bmoon4/ldap-test.git temp
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

# git push
git push -u --set-upstream origin $new_branch

# git pull request
git request-pull origin/main https://github.com/bmoon4/ldap-test $new_branch

# Opening PR link : https://github.com/bmoon4/ldap-test/pull/new/${new_branch}

# clean up temp folder
rm -rf temp


echo "############################# Pool setup ###############################"

# git clone
mkdir temp
echo "git clone"
git clone https://XXXXX@github.com/bmoon4/pool-test.git temp
cd temp

# git checkout -b onboarding-$appcode
echo "git checkout -b"
git checkout -b $new_branch

#add new change
echo "add changes"
echo $pool >> configs/dev/pools.yaml
echo $pool >> configs/qa/pools.yaml
echo $pool >> configs/uat/pools.yaml
echo $pool >> configs/prod/pools.yaml
echo "git add ."
git add .

# git commit

echo "git commit"
git commit -m "[pool] new appcode onboarding"

# git push
git push -u --set-upstream origin $new_branch

# git pull request
git request-pull origin/main https://github.com/bmoon4/pool-test $new_branch

# Opening PR link : https://github.com/bmoon4/pool-test/pull/new/${new_branch}

# clean up temp folder
rm -rf temp

exit 0
