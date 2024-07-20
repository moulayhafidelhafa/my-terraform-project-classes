clean:
	find / -type d -name ".terraform" -exec rm -rf {} \;


build:
	terraform init  && terraform apply -auto-approve



destroy:
	terraform init  && terraform destroy -auto-approve
	