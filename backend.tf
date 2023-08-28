
terraform {
  backend "s3" {
    bucket         = "revterrback"
    key            = "jenkinsassign/dev"
    region         = "us-east-1"
    dynamodb_table = "revterrback"
  }
}
