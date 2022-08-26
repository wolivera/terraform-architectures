# Terraform Architectures: S3 Cloudfront Website

This terraform setup can be used to setup an static website using S3 bucket and a Cloudfront distribution. This setup is recommended for hosting web frontend apps in AWS in a static way. Github actions can also be integrated in order to have a CI/CD flow.

<p align="center">
  <img src="https://hands-on.cloud/wp-content/uploads/2022/06/cloudfront-s3.drawio.png?ezimgfmt=ng:webp/ngcb1" />
</p>

## Resources

This setup creates the following resources:

- S3 Bucket
- S3 Bucket policies that restrict public access and only allow access from the Cloudfront distribution
- A Cloudfront distribution
- A Cloudfront Origin Access Identity
- A Route53 A Record entry pointing to cloudfront distribution

### Usage

- Create your own `secrets.tfvars` based on `secrets.example.tfvars`, insert the values for your AWS access key and secrets. If you don't create your `secrets.tfvars`, don't worry, Terraform will interactively prompt you for missing variables later on. Also create your `environment.tfvars` file to manage non-secret values for different environments or projects with the same infrastructure

- Execute `terraform init`, it will initialize your local terraform and connect it to the state store, and it will download all the necessary providers

- Execute `terraform plan -var-file="secrets.tfvars" -var-file="environment.tfvars" -out="out.plan"` - this will calculate the changes terraform has to apply and creates a plan. If there are changes, you will see them. Check if any of the changes are expected, especially deletion of infrastructure.

- If everything looks good, you can execute the changes with `terraform apply out.plan`


In case you no longer want this architecture to run. Run (carefully) the command `terraform destroy`


### Test

This example already comes with a sample Web application under the `website` folder that gets deployed to the S3 bucket. If terraform deployment is successfull you should be able to find your application at the provided url.


