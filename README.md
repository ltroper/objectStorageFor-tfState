# Tutorial: Uploading Terraform State to Linode Object Storage

In this tutorial, we will walk through the process of setting up Linode Object Storage as a backend for storing Terraform state files. 
This allows you to securely manage your infrastructure state while taking advantage of Linode's reliable object storage service.

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

1. Terraform installed on your local machine.
2. A Linode account. If you don't have one, sign up for a Linode account at https://www.linode.com/.
3. A personal access token for Linode

## Step 1: Create a Linode Object Storage Bucket

1. Log in to your Linode account.
2. From the Linode Dashboard, navigate to "Object Storage" under the "Storage" section.
3. Click on "Create a Bucket" and provide a unique name for your bucket. Ensure you remember this bucket name as it will be used in Terraform configuration.
4. Click "Create"

## Step 2: Generate Linode Object Storage Access Keys

1. In the Linode Object Storage section, click on your newly created bucket.
2. Under the "Bucket Tools" section, select "Access Keys."B
3. Click "Create a Key Pair" to generate access keys for reading and writing to your bucket.
4. Save the generated Access Key ID and Secret Access Key. You will need these credentials to configure Terraform.

## Step 3: Configure Terraform
Now, let's configure Terraform to use Linode Object Storage as a backend for storing state files.

### Create main.tf File
Create a file named main.tf in your Terraform project directory with the following content:
```
terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.27.1"
    }
  }
}

provider "linode" {
  token = var.token
}

# Define your infrastructure resources below this line
```
This main.tf file sets up the Linode provider for your Terraform project.


### Create terraform.tfvars File
Create a file named terraform.tfvars in your Terraform project directory and set the "token" and "region" variables.
Use your Personal Access Token and desired region.

### Create backend.tf File

```
terraform {
  backend "s3" {
    endpoint                    = "<Linode endpoint for your bucket region>"
    bucket                      = "<your-bucket-name>"
    key                         = "<your-folder-name>/state.tfstate"
    region                      = "us-east-1"
    skip_credentials_validation = true
  }
}
```
### Set Environment Variables for Linode Access Keys
In your shell, export the Linode Object Storage access keys as environment variables:
```
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
```

## Step 4: Initialize and Apply Terraform
```
terraform init
terraform apply
```
Terraform will now use Linode Object Storage as the backend to store the state files.

## Conclusion
You have successfully configured Terraform to use Linode Object Storage as a backend for storing your infrastructure state files, organized within a folder. This provides a secure and reliable way to manage your state files while leveraging Linode's object storage service.

Remember to keep your Linode Object Storage access keys secure and do not hardcode them in your configuration files for security reasons.
