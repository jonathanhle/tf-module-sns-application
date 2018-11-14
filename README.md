## Amazon Web Services SNS Application

[![Build Status](http://jenkins.services.dat.internal/buildStatus/icon?job=DevOps/Terraform/Modules/tf-module-sns-application/master)](http://jenkins.services.dat.internal/job/DevOps/job/Terraform/job/Modules/job/tf-module-sns-application/)

Terraform module used to provision an IAM Role. Currently supports creating roles for the following uses:

  - An IAM user in a different AWS account as the role
  - A web service offered by AWS such as Amazon Elastic Compute Cloud (Amazon EC2)

Official AWS documentation: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html

## Requirements
- - - -

This module requires:

   -  [AWS Provider](https://github.com/terraform-providers/terraform-provider-aws) `>= 1.17.0`
   -  [Template Provider](https://github.com/terraform-providers/terraform-provider-template) `>= 1.0.0`
   -  [Random Provider](https://github.com/terraform-providers/terraform-provider-random) `>= 2.0.0`

### Inputs
- - - -

This module takes the following inputs:

  Name          | Description   | Type          | Default
  ------------- | ------------- | ------------- | -------------
  name          | Name of the role and policies  | String |
  name_prefix   | Added prefix to role name (useful if you every plan on changing the role name)  | Boolean       | true
  type          | Role trust entity (valid values: service, account) | String |
  service       | AWS service this role will be used by (required when type service) | String | ""
  account_id    | AWS Account this role will be used by (required when type account) | String | ""
  account_user  | AWS Account user this role will be used by (only required for type account) | String | root
  external_id   | When set, enable external ID (required when type account) | String | ""
  create_policy | Map containing details of the policy to create and attach to role | Map | {}
  existing_policy | List of existing policies to attach to role | List | []

### Ouputs
- - - -

This module exposes the following outputs:

  Name          | Description   | Type
  ------------- | ------------- | -------------
  role_arn | ARN of the created role  | String
  instance_profile_arn | ARN of the created instance profile (valid when type service and service ec2) | String
  instance_profile_name | Name of the created instance profile (valid when type service and service ec2) | String


## Usage
- - - -

Create IAM role with trust entitty to another AWS Account.

```hcl

module "iam_role_account" {
  source = "git::ssh://git@bitbucket.org/dat/tf-module-am-role.git?ref=master"

  name = "example"
  /* role name will be example with no added prefix */
  name_prefix = false

  type = "account"

  /* type = account so we must specify the account_id and possibly external_id */
  account_id  = "755621335444"
  external_id = "123456"

  /* example_policy.tpl must exist in the current working directory */
  create_policy {
    template = "example_policy.tpl"
    key      = "key1,key2"
    value    = "value1,value2"
  }

  /* required to allow create_policy to include interpolation */
  create_policy_count = 1

  existing_policy = [ "AdministratoryAccess" ]
}

```

Create IAM role to be used by AWS EC2 service.

```hcl

module "iam_role_service" {
  source = "git::ssh://git@bitbucket.org/dat/tf-module-am-role.git?ref=master"

  name = "example"
  /* role name will be example with no added prefix */
  name_prefix = false

  type    = "service"
  service = "ec2"

  /* example_policy.tpl must exist in the current working directory */
  create_policy {
    template = "example_policy.tpl"
    key      = "key1,key2"
    value    = "value1,value2"
  }

  /* required to allow create_policy to include interpolation */
  create_policy_count = 1
}

```

