#!/bin/bash -l

set -e

# source bosh-src/ci/tasks/utils.sh
check_param IMAGE_TO_BE_BUILT

# set_up_vagrant_private_key

# cd bosh-src
print_git_state

# gem install bundler --version 1.11.2 --no-ri --no-rdoc
# bundle install --local
# bundle exec rake --trace ci:publish_os_image_in_vm[$OPERATING_SYSTEM_NAME,$OPERATING_SYSTEM_VERSION,remote,$OS_IMAGE_S3_BUCKET_NAME,$OS_IMAGE_S3_KEY]

echo "==================="
echo $IMAGE_TO_BE_BUILT
echo "==================="

echo "hello" >> test.txt
git log -n 1

cat test.txt