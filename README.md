## Amazon Web Services SNS Application

[![Build Status](http://jenkins.dat.com/buildStatus/icon?job=DevOps/Terraform/Modules/tf-module-sns-application/master)](http://jenkins.dat.com/job/DevOps/job/Terraform/job/Modules/job/tf-module-sns-application/)

Terraform module use to configure SNS for User Notifications with a Mobile Application as a Subscriber (Mobile Push). Currently supports Google Cloud Messaging and Apple Push Notification Service.

Official AWS documentation: https://docs.aws.amazon.com/sns/latest/dg/sns-mobile-application-as-subscriber.html

## Requirements
- - - -

This module requires:

   -  [AWS Provider](https://github.com/terraform-providers/terraform-provider-aws) `>= 1.17.0`

### Inputs
- - - -

This module takes the following inputs:

  Name          | Description   | Type          | Default
  ------------- | ------------- | ------------- | -------------
  `name`          | Name of the SNS application.  | string | -
  `platform`      | Either APNS or GCM. | string | -
  `platform_credential` | See https://docs.aws.amazon.com/sns/latest/dg/mobile-push-send-register.html. | string | -
  `platform_principal` | See https://docs.aws.amazon.com/sns/latest/dg/mobile-push-send-register.html. | string | -
  `use_secret_manager` | If true, the values of credential and principal are secrets stored in AWS Secrets manager. | boolean | `false`
  `apns_sandbox` | Use SANDBOX for APNS | boolean | `true`

### Ouputs
- - - -

This module exposes the following outputs:

  Name          | Description   | Type
  ------------- | ------------- | -------------
  `sns_application_arn` | ARN of the SNS platform application | string
  `sns_application_id` | ARN of the SNS platform application | string

## Usage
- - - -

Apple Push Notification Service (APNS)

```hcl


module "apns" {
  source = "git::ssh://git@bitbucket.org/dat/tf-module-sns-application.git?ref=master"

  name = "apns"

  platform = "apns"

  platform_credential = "APNS"
  platform_principal  = "APNS_certificate"

  use_secret_manager = true
}

```

Google Cloud Messaging (GCM)

```hcl


module "gcm" {
  source = "git::ssh://git@bitbucket.org/dat/tf-module-sns-application.git?ref=master"

  name = "gcm"

  platform = "gcm"

  platform_credential = "GCM"

  use_secret_manager = true
}

```

