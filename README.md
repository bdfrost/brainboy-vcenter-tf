# brainboy-vcenter-tf
# https://github.com/tfutils/tfenv

## MAC INSTALL
$ brew install tfenv


## Ubuntu Install
$ git clone https://github.com/tfutils/tfenv.git ~/.tfenv
$ echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
$ mkdir -p ~/.local/bin/
$ . ~/.profile
$ ln -s ~/.tfenv/bin/* ~/.local/bin
$ which tfenv


# Set token
$ vi .terraformrc
 credentials "app.terraform.io" {
    token = "dgjfFGBtccNSTUFF.STUFFF.STUFFrPy3TeBwlk8QepgHa3pWk"
}


# GENERAL DOCS FOR TFENV
$ tfenv install 0.11.14
$ tfenv list

$ echo "latest:^0.11" > ${HOME}/.terraform-version
# or
$ echo "0.11.13" > ${HOME}/code/project-foo/infra/.terraform-version
# or
$ echo "latest:^0.11" > ${HOME}/git/brainboy-vcenter-tf/.terraform-version


# TFENV FOR THIS ENV
$ tfenv install

$ cd ${HOME}/git/brainboy-vcenter-tf/
$ tfenv install `cat ${HOME}/git/brainboy-vcenter-tf/.terraform-version`
$ terraform version

$ terraform plan # All of the vcenter creds are stored in terraform.io
