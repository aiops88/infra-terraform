terraform {
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "dataviz-bookstoretf-state"
    key            = "bookstore/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bookstore-lock-table"
    encrypt        = true
  }
}
