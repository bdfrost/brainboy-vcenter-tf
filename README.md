# brainboy-vcenter-tf
# https://github.com/tfutils/tfenv

# brew install tfenv
# tfenv install 0.11
# tfenv list

# $ echo "latest:^0.11" > ${HOME}/.terraform-version
# or
# $ echo "0.11.13" > ${HOME}/code/project-foo/infra/.terraform-version
# or
# $ echo "latest:^0.11" > ${HOME}/git/brainboy-vcenter-tf/.terraform-version

# $ tfenv install

# $ cd ${HOME}/git/brainboy-vcenter-tf/
# $ tfenv install `cat ${HOME}/git/brainboy-vcenter-tf/.terraform-version`
# $ terraform version

# $ terraform plan # All of the vcenter creds are stored in terraform.io