<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.37.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.37.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.ec2_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability zone in which the machine will be launched | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name for the instance that will be created | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance that will be launched | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH key that will be used to connect to the instance | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID in which the instance will be launched | `string` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Initial size of the EBS | `number` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of security group IDs to associate with the instance | `list(string)` | `null` | no |
<!-- END_TF_DOCS -->

## Usage

 1. Update the file ``/env/backend_s3_devops.hcl`` with your bucket's details.

 2. Create a file named ``main.tf`` and add the following content.

````hcl
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.37.0"
    }   
  }
  backend "s3" {} #Init with -backend-config parameter 
}
provider "aws" {
  region = "us-east-1"
}

module "ec2_create" {
   source = "git::git@github.com:So4resAlex/ec2-create.git?ref=v1.0.1"
   availability_zone = "us-east-1a"
   instance_type = "t3.nano"
   key_name = "{your key}"
   subnet_id = "subnet-{id here}"
   vpc_security_group_ids = ["sg-{id here }"]
   volume_size = 20
   instance_name = "Terraform-lab"
   environment = "DevOps"
 }

3. Initialize the Terraform project using the command below.
``terraform init -backend-config="env/backend_s3_devops.hcl"``
4. Generate the execution plan using the command below.
``terraform plan -out plano``
5. Apply the execution plan with the command below.
``terraform apply plan``
````