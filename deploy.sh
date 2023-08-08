cd terraform
terraform apply -auto-approve 
ip_add=$(cat jenkins-ip.txt)
cp Credit.txt ../ansible/
cd ../ansible
export ANSIBLE_HOST_KEY_CHECKING=False
sed -i "s|\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}|$ip_add|g" inventory
ansible-playbook playbook.yaml -i inventory