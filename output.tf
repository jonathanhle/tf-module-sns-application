/* sns application outputs */
output "sns_application_arn" { value = "${join("", list(join("", aws_sns_platform_application.apns.*.arn),
                                                        join("", aws_sns_platform_application.gcm.*.arn)
                                                       ))}" }

output "sns_application_id" { value = "${join("", list(join("", aws_sns_platform_application.apns.*.id),
                                                       join("", aws_sns_platform_application.gcm.*.id)
                                                      ))}" }
