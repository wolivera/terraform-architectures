# Terraform Architectures: AWS EC2

This terraform setup can be used to setup a server, aka EC2 instance on AWS infrastructure. This setup is recommended for very simple use cases that need only a cloud server to showcase a web app or api.

## Resources

This setup creates the following resources:

- VPC
- One public and one private subnet
- Routing tables for the subnets
- One security groups that allows HTTP access on port 80


### Usage

- Create your own `secrets.tfvars` based on `secrets.example.tfvars`, insert the values for your AWS access key and secrets. If you don't create your `secrets.tfvars`, don't worry. Terraform will interactively prompt you for missing variables later on. Also create your `environment.tfvars` file to manage non-secret values for different environments or projects with the same infrastructure

- Execute `terraform init`, it will initialize your local terraform and connect it to the state store, and it will download all the necessary providers

- Execute `terraform plan -var-file="secrets.tfvars" -var-file="environment.tfvars" -out="out.plan"` - this will calculate the changes terraform has to apply and creates a plan. If there are changes, you will see them. Check if any of the changes are expected, especially deletion of infrastructure.

- If everything looks good, you can execute the changes with `terraform apply out.plan`


In case you no longer want this architecture to run. Run (carefully) the command `terraform destroy`

You can automate these commands for example using Github Actions.


### Test

The easiest setup to try out this infrastructure is to run a basic node app into the EC2 instance. In order to do so, we will manually copy the necessary files into the remote server and simply start the app. 
Follow below steps:

1. The configuration has created an ec2 instance in a public subnet with open access for ssh connection. This setup assumes you have set a Key Pair name that you have access to. So login into the instance

```sh
$ ssh -i <yourkey>.pem ec2-user@<instance-ip>
```

1. Once in, `clone` this repository and step into the `aws-ec2` folder

1. Install `node` and `npm` in the system and then run `npm install` command

1. Simply run the node app using `npm start`. This will start the server in the `8080` port (which matches the security group ingress configuration)

1. Test you can access the app by pasting into a browser `<public-ip-address>:8080`
