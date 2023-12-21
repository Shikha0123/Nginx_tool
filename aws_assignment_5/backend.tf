# terraform {
#     backend "s3" {
#         bucket = "dev1"
#         key = "tf-state-file/terraform.tfstate"
#         region = "eu-west-1"
#         dynamodb_table = "terraform_state"
#         encrypt = true
#     }
# }

terraform {

  backend "s3" {

    bucket         = "adityabucket63"

    key            = "Assignment/terraform.tfstate"

    region         = "us-east-1"

    dynamodb_table = "terraform-dynamodb1"

    encrypt        = true

  }

}
