terraform {
  backend "s3" {
    endpoint = "https://us-southeast-1.linodeobjects.com"
    bucket = "terraform-backend"
    key    = "infra/state.json"
    region = "us-east-1"
    skip_credentials_validation = true
  }
}