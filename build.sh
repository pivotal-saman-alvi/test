#!/bin/bash -l

set -e

# source bosh-src/ci/tasks/utils.sh

# set_up_vagrant_private_key

# cd bosh-src
# print_git_state

# gem install bundler --version 1.11.2 --no-ri --no-rdoc
# bundle install --local
# bundle exec rake --trace ci:publish_os_image_in_vm[$OPERATING_SYSTEM_NAME,$OPERATING_SYSTEM_VERSION,remote,$OS_IMAGE_S3_BUCKET_NAME,$OS_IMAGE_S3_KEY]

echo $OS_IMAGE
echo $IMAGE_VERSION

os_image_version="hashfrombuildthing"
cd bosh-src

# get sha of commit that this os image was built for
git log -n 1 >> sha.txt
line=$(head -n 1 sha.txt)
arr=($line)
sha=${arr[1]}

# grabbing message on commit
message=`git log --pretty=oneline --abbrev-commit -n 1`
echo -e $sha >> README.md
echo -e $message >> README.md


# replacing the right uploaded blob hash in the json file
FILE=test.json

while read line; do
	if [[ $line =~ $OS_IMAGE && $line =~ $IMAGE_VERSION ]]
	then
		LAST_CHAR=""

		# because we want to know whether or not we need a comma
		if [[ ${line: -1} == "," ]]
		then
			LAST_CHAR=','
		fi

		line=${line/:*/:\"$os_image_version\"$LAST_CHAR}
		echo $line
	fi

	echo $line >> tmprandomname.json
done < $FILE

cp tmprandomname.json $FILE
rm -rf tmprandomname.json


# committing
git config --global user.email salvi@pivotal.io 
git config --global user.name SamanGit

git add README.md
git commit -m "updating message"

cd ..

# because we aren't compiling or building something we have to do this
# it is bad ... there's no work around
cp -a bosh-src/ bosh-out/