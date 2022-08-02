# Terraform Architectures: AWS ECS/Fargate

This terraform setup can be used to setup the AWS infrastructure for a dockerized application running on ECS with Fargate launch configuration.

## Resources

This setup creates the following resources:

- VPC
- One public and one private subnet per AZ
- Routing tables for the subnets
- Internet Gateway for public subnets
- NAT gateways with attached Elastic IPs for the private subnet
- Two security groups
  - one that allows HTTP/HTTPS access
  - one that allows access to the specified container port
- An ALB + target group with listeners for port 80 and 443
- An ECR for the docker images
- An ECS cluster with a service (incl. auto scaling policies for CPU and memory usage)
  and task definition to run docker containers from the ECR (incl. IAM execution role)
- Secrets - a Terraform module that creates many secrets based on a `map` input value, and has a list of secret ARNs as an output value

![example](https://d2908q01vomqb2.cloudfront.net/1b6453892473a467d07372d45eb05abc2031647a/2018/01/26/Slide5.png "Infrastructure illustration")

### Usage

- Create your own `secrets.tfvars` based on `secrets.example.tfvars`, insert the values for your AWS access key and secrets. If you don't create your `secrets.tfvars`, don't worry. Terraform will interactively prompt you for missing variables later on. You can also create your `environment.tfvars` file to manage non-secret values for different environments or projects with the same infrastructure

- Execute `terraform init`, it will initialize your local terraform and connect it to the state store, and it will download all the necessary providers

- Execute `terraform plan -var-file="secrets.tfvars" -var-file="environment.tfvars" -out="out.plan"` - this will calculate the changes terraform has to apply and creates a plan. If there are changes, you will see them. Check if any of the changes are expected, especially deletion of infrastructure.

- If everything looks good, you can execute the changes with `terraform apply out.plan`


In case you no longer want this architecture to run. Run (carefully) the command `terraform destroy`

### Test

This setup comes with a basic Node app and a Dockerfile so you can see everything running. Try to build and push the Docker image to the created ECR. Use the following commands:

```bash
// Build your image
$ docker build -t terraform-demo --target=app .

// Login into AWS
$ aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin "<aws-account-id>.dkr.ecr.<region>.amazonaws.com"

// Tag the image
$ docker tag terraform-demo:latest <repo-url>:latest

// Push the image
$ docker push <repo_url>:latest
```

You can automate these commands for example using Github Actions.
