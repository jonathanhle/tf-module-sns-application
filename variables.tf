################################################
#        Local Variable defintions             #
################################################
locals {
  platform = "${upper(var.platform)}"

  platform_credential = "${var.use_secret_manager ? join("", data.aws_secretsmanager_secret_version.credential.*.secret_string) : var.platform_credential}"
  platform_principal  = "${var.use_secret_manager ? join("", data.aws_secretsmanager_secret_version.principal.*.secret_string)  : var.platform_principal}"
}

variable "name" {}

variable "platform"            {}
variable "platform_credential" {}
/* only required when platform is APNS */
variable "platform_principal"  { default = "" }

/* only relevant when platform is APNS */
variable "apns_sandbox" { default = true }

variable "use_secret_manager" { default = false }
