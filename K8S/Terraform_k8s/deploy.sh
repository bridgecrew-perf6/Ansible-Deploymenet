source ~/.bash_profile
cat /dev/null > ../Inventory/inventory.txt
terraform plan \
  -out out.terraform
terraform apply out.terraform
sleep 10
sh ansible.sh
cd ../;
for i in {1..5}
  do
    sleep 3
  done
ansible-playbook k8s.yml -i Inventory/inventory.txt
