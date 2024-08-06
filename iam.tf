# Create an IAM role for CloudWatch logging
resource "aws_iam_role" "cloudwatch_logging_role" {
  name = "s3-cloudwatch-logging-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
      }
    ]
  })
}

# Attach policy to the IAM role
resource "aws_iam_role_policy" "cloudwatch_logging_policy" {
  name = "s3-cloudwatch-logging-policy"
  role = aws_iam_role.cloudwatch_logging_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.my_log_group.arn}:*"
      }
    ]
  })
}

# IAM role for SNS to write to CloudWatch Logs
resource "aws_iam_role" "sns_delivery_status_role" {
  name = "sns-delivery-status-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
      }
    ]
  })
}

# Attach policy to the IAM role
resource "aws_iam_role_policy" "sns_delivery_status_policy" {
  name = "sns-delivery-status-policy"
  role = aws_iam_role.sns_delivery_status_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.sns_delivery_status.arn}:*"
      }
    ]
  })
}
