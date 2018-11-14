data aws_secretsmanager_secret "credential" {
  count = "${var.use_secret_manager}"

  name = "${var.platform_credential}"
}

data aws_secretsmanager_secret_version "credential" {
  count = "${var.use_secret_manager}"

  secret_id = "${data.aws_secretsmanager_secret.credential.id}"
}

data aws_secretsmanager_secret "principal" {
  count = "${var.use_secret_manager * (local.platform == "APNS" ? 1 : 0)}"

  name = "${var.platform_principal}"
}

data aws_secretsmanager_secret_version "principal" {
  count = "${var.use_secret_manager * (local.platform == "APNS" ? 1 : 0)}"

  secret_id = "${data.aws_secretsmanager_secret.principal.id}"
}

resource aws_sns_platform_application "apns" {
  count = "${local.platform == "APNS" ? 1 : 0}"

  name = "${var.name}"

  platform            = "${var.apns_sandbox ? format("%s_SANDBOX", local.platform) : local.platform}"
  /* APNS private key */
  platform_credential = "${local.platform_credential}"
  /* APNS certificate */
  platform_principal  = "${local.platform_principal}"
}

resource aws_sns_platform_application "gcm" {
  count = "${local.platform == "GCM" ? 1 : 0}"

  name = "${var.name}"

  platform            = "${local.platform}"
  /* GCM API key */
  platform_credential = "${local.platform_credential}"
}
