module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 3.0"

  name  = "${var.application_name}-${var.environment}-alarm"
}
