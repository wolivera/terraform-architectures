# Terraform Architectures: AWS Elastic Beanstalk

This terraform setup can be used to setup an Elastic Beanstalk stack on AWS infrastructure. This setup is recommended for standard up to medium-size applications that need an scalable setup that combines https, a load balancer and application versions. EB provides also the ability to easily spin up additional environments. Github actions can also be integrated in order to have a CI/CD flow.

## Resources

This setup creates the following resources:

- VPC with 2 availability zones (configurable)
- One public subnet per AZ for the Elastic Load Balancer
- One private subnet per AZ for the EC2 instances
- A route table, NAT gateway and IP Elastic Address for the communication with the outside world of the EC2 instance
- Cloudwatch log groups for the running application
- EC2 instance
- An Elastic Load Balancer
- An Elastic Beanstalk application
- An Elastic Beanstalk environment
- Cloudwatch alarms for API metrics with SNS topic
- An RDS Instance with PostgreSQL 
- A DocumentDB with MongoDB

<img width="962" alt="image" src="https://user-images.githubusercontent.com/4985062/186955222-c2913d8a-90ea-43cb-8ace-7f27ad9246c2.png">


### Usage

- Create your own `secrets.tfvars` based on `secrets.example.tfvars`, insert the values for your AWS access key and secrets. If you don't create your `secrets.tfvars`, don't worry, Terraform will interactively prompt you for missing variables later on. Also create your `environment.tfvars` file to manage non-secret values for different environments or projects with the same infrastructure

- Execute `terraform init`, it will initialize your local terraform and connect it to the state store, and it will download all the necessary providers

- Execute `terraform plan -var-file="secrets.tfvars" -var-file="environment.tfvars" -out="out.plan"` - this will calculate the changes terraform has to apply and creates a plan. If there are changes, you will see them. Check if any of the changes are expected, especially deletion of infrastructure.

- If everything looks good, you can execute the changes with `terraform apply out.plan`


In case you no longer want this architecture to run. Run (carefully) the command `terraform destroy`


### Test

This example already comes with a sample NodeJs application as part of the Beanstalk stack. If terraform deployment is successfull you should be able to find your application at the generated Beanstalk url. You can then assign a Route53 entry to map your custom domain/certificate with this URL.


