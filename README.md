# AWS - Terraform

This repo contains Terraform code for the provisioning of AWS resources.

A [Symfony 3 API](https://github.com/bendbennett/symfony-api-swagger-jwt) is used to 
illustrate how a web application which can be run within a [Docker-based](https://github.com/bendbennett/docker-compose-nginx-php7-mongo3) 
local development environment can be set-up to run on AWS. 
 
## Requirements

* Install [Terraform]()
* Set-up Terraform for [authenticating with the AWS Provider](https://www.terraform.io/docs/providers/aws/).
  * I'm using [environment variables](https://www.terraform.io/docs/providers/aws/#environment-variables) 
  so have just added something like the following to my `~/.bash_profile`
  
        export AWS_ACCESS_KEY_ID=******************
        export AWS_SECRET_ACCESS_KEY=**************  

### Clone this repo

        git clone git@github.com:bendbennett/aws-terraform.git

### S3

* [Create an S3 bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html)
 called _synaptology-templates_ and upload 
[scripts/upsert-resource-record-set.sh](../master/scripts/upsert-resource-record-set.sh)
to this bucket.

### Register domain name

* Register a domain name using [AWS Route 53](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar.html).
* Create a [public hosted zone](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/AboutHZWorkingWith.html)
for the domain.
* Add the public hosted zone id and name to _hosted_zone_public_id_ and _hosted_zone_public_name_
 in [global/private.tf](../master/global/private.tf).

### HTTPS

* [Create a certificate](https://aws.amazon.com/certificate-manager/) for *._hosted_zone_public_name_
  (i.e., name inserted for _hosted_zone_public_name_ in the previous step).
* Add the SSL certificate ARN to _ssl_certificate_id_ in [global/private.tf](../master/global/private.tf).

### Key name

* Add the name of the key that you want to user to connect to thne EC2 instances to 
_key_name_ in [global/private.tf](../master/global/private.tf).

## Provision IAM roles, VPC and API

    cd aws-terraform/global
    terraform get
    terraform init
    terraform plan
    terraform apply
    
    cd aws-terraform/prod/vpc
    terraform get
    terraform init
    terraform plan
    terraform apply   

    cd aws-terraform/prod/services/api
    terraform get
    terraform init
    terraform plan
    terraform apply

## Remove API, VPC and IAM roles

    cd aws-terraform/prod/services/api
    terraform destroy
    
    cd aws-terraform/prod/vpc    
    terraform destroy
    
    cd aws-terraform/global
    terraform destroy     
 
## Inspiration

The directory layout, modularization and a bunch of other stuff was inspired by [Charity
Majors](https://charity.wtf/2016/03/30/terraform-vpc-and-why-you-want-a-tfstate-file-per-env/), 
[Yvegeniy Brikman / Gruntwork](https://blog.gruntwork.io/a-comprehensive-guide-to-terraform-b3d32832baca) 
and a couple of postings on [Stack Overflow](https://stackoverflow.com/questions/33157516/best-practices-when-using-terraform).

## To Do

* Switch to using a versioned S3 bucket for storing remote state.
* Switch to using git tags for module source.
