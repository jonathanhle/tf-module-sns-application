module "test1" {
  source = "../"

  name = "unit-test01"

  platform = "gcm"

  platform_credential = "GCM"

  use_secret_manager = true
}

module "test2" {
  source = "../"

  name = "unit-test02"

  platform = "apns"

  platform_credential = "APNS"
  platform_principal  = "APNS_certificate"

  use_secret_manager = true
}

