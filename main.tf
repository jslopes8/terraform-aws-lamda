data "archive_file" "main" {
    count   = var.create ? length(var.archive_file) : 0

    type        = lookup(var.archive_file[count.index], "type", null)
    source_dir  = lookup(var.archive_file[count.index], "source_dir", null)
    output_path = lookup(var.archive_file[count.index], "output_path", null)
}

resource "aws_lambda_function" "main" {
    count   = var.create ? 1 : 0

    function_name       = var.function_name
    filename            = data.archive_file.main.0.output_path
    description         = var.description
    handler             = var.handler
    role                = var.role
    runtime             = var.runtime
    timeout             = var.timeout
    source_code_hash    = data.archive_file.main.0.output_base64sha256

    dynamic "vpc_config" {
        for_each = var.vpc_config
        content {
            subnet_ids          = vpc_config.value.subnet_ids
            security_group_ids  = vpc_config.value.security_group_ids
        }
    }

    environment {
        variables   = var.environment
    }

    tags    = var.default_tags
}
resource "aws_lambda_permission" "main" {
    count   = var.create ? length(var.lambda_permission) : 0

    statement_id  = lookup(var.lambda_permission[count.index], "statement_id", null)
    action        = lookup(var.lambda_permission[count.index], "action", null)
    function_name = aws_lambda_function.main.0.function_name
    principal     = lookup(var.lambda_permission[count.index], "principal", null)
    source_arn    = lookup(var.lambda_permission[count.index], "source_arn", null)
}

resource "aws_cloudwatch_log_group" "main" {
  count   = var.create ? 1 : 0

  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days
}