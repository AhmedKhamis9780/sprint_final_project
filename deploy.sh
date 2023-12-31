cd terraform
terraform init
terraform apply -auto-approve 
ip_add=$(cat jenkins-ip.txt)
cp tf-key-pair ../ansible/tf-key-pair.pem
cd ../ansible
chmod 400 tf-key-pair.pem
export ANSIBLE_HOST_KEY_CHECKING=False

sed -i "s/ansible_host=[0-9.]\+/ansible_host=$ip_add/g" inventory

ansible-playbook playbook.yaml -i inventory