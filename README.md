# AWS Lambda Terraform Module

## Usage
```bash
module "create_lambda" {
  source = ""

  function_name = local.stack_name
  description   = "${local.stack_name} Function"

  ## Expected Runtime: nodejs nodejs4.3 nodejs6.10 nodejs8.10 nodejs10.x nodejs12.x nodejs14.x java8 java8.al2 java11 python2.7 
  ## python3.6 python3.7 python3.8 dotnetcore1.0 dotnetcore2.0 dotnetcore2.1 dotnetcore3.1 nodejs4.3-edge go1.x 
  ## ruby2.5 ruby2.7 provided provided.al2
  handler = "lambda_function.lambda_handler"
  runtime = "python3.6"
  timeout = "3"
  role    = module.iam_role_lambbda.role_arn

  environment = {
    Env = "Dev"
  }

  archive_file = [{
    type        = "zip"
    source_dir  = "lambda-code"
    output_path = "lambda-code/lambda_function.zip"
  }]

  lambda_permission   = [
    {
      statement_id  = "AllowExecutionFromCloudWatch"
      action        = "lambda:InvokeFunction"
      principal     = "events.amazonaws.com"
      source_arn    = module.bl_eventbridge.cw_arn
    },
    {
      statement_id  = "AllowExecutionFromSNS"
      action        = "lambda:InvokeFunction"
      principal     = "sns.amazonaws.com"
      source_arn    = module.bl_sns_topic.topic_arn
    }
  ]

  default_tags = local.default_tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Variables Inputs
| Name | Description | Required | Type | Default |
| ---- | ----------- | -------- | ---- | ------- |


## Variable Outputs
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
| Name | Description |
| ---- | ----------- |
