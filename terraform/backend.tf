# terraform {
#   backend "s3" {
#     bucket         = "BUCKET_NAME"
#     key            = "terraform.tfstate"
#     region         = "eu-central-1"
#     encrypt        = true
#     dynamodb_table = "TABLE_NAME"
#   }
# }