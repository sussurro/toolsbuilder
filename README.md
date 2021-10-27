Make sure you are running the latest versions of packer, ansible, and terraform
to build the image, make sure your default config for aws cli is setup correctly
Go into the packer directory and type:    packer build build_server_template.json

Next, go into the terraform directory and do terraform apply. If you want to limit firewall rules, copy the tvfars template to a terraform.tfvars and fill in the data. The terraform apply will build th ebox and create an inventory file in the ansible directory.

wait for about 5 mins for the box to spin up

Go into the ansible directory and type in : ansible-playbook -i inventory toolsbuild.yml 

inside the ansible/roles/tools_cust/files folder there is a json file with the config for build. Update that with packages that you want. When you run the plabook it will download a Binaries.7z file to the root of the project.


