# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-great-bucket-name" # Change this to a globally unique name
}

# Create an S3 bucket notification to SNS
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.my_bucket.id

  topic {
    topic_arn = aws_sns_topic.my_topic.arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_sns_topic_policy.default]
}