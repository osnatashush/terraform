# Terraform Template Repository

## What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool created by HashiCorp. It allows you to define, provision, and manage cloud infrastructure and resources using a simple, declarative configuration language. With Terraform, you can automate the setup of infrastructure across multiple cloud providers (like AWS, Azure, GCP) and services in a consistent and repeatable way.

## What does this repository do?

This repository provides a reusable template for starting new Terraform projects. It includes the recommended structure and example configuration files:

- `main.tf`: Main entry point for resources and backend configuration.
- `variables.tf`: Input variable definitions.
- `outputs.tf`: Output values definitions.
- `versions.tf`: Required Terraform and provider versions.

You can use this template as a starting point for your own Terraform modules or infrastructure projects.

## How to use this template

1. **Clone this repository:**
   ```sh
   git clone <your-repo-url>
   cd <repo-directory>
   ```
2. **Customize the Terraform files:**

   - Edit `main.tf` to add your resources.
   - Define your input variables in `variables.tf`.
   - Add output values in `outputs.tf`.
   - Adjust provider or Terraform version constraints in `versions.tf` if needed.

3. **Configure the backend (S3 example):**
   To store your Terraform state remotely and securely, configure the S3 backend. Uncomment and fill in the `backend "s3"` block in `main.tf`.

## Setting up S3 as a Terraform backend

Follow these steps to create and secure an S3 bucket for Terraform state:

1. **Create the S3 bucket:**
   ```sh
   aws s3 mb s3://delivops-terraform-tfstate \
     --region eu-west-1 || :
   ```
2. **Block public access:**
   ```sh
   aws s3api put-public-access-block \
     --bucket delivops-terraform-tfstate \
     --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" \
     --region eu-west-1 || :
   ```
3. **Enable versioning:**

   ```sh
   aws s3api put-bucket-versioning \
     --bucket delivops-terraform-tfstate \
     --versioning-configuration "Status=Enabled" \
     --region eu-west-1 || :
   ```

4. **(Optional) Create a DynamoDB table for state locking:**

   ```sh
   aws dynamodb create-table \
     --table-name terraform-lock \
     --attribute-definitions AttributeName=LockID,AttributeType=S \
     --key-schema AttributeName=LockID,KeyType=HASH \
     --billing-mode PAY_PER_REQUEST \
     --region eu-west-1 || :
   ```

5. **Update your `main.tf` backend block:**
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "delivops-terraform-tfstate"
       key            = "terraform.tfstate"
       region         = "eu-west-1"
       dynamodb_table = "terraform-lock" # optional
       encrypt        = true
     }
   }
   ```

## Applying your Terraform configuration

1. **Initialize Terraform:**
   ```sh
   terraform init
   ```
2. **Plan your changes:**
   ```sh
   terraform plan
   ```
3. **Apply your changes:**
   ```sh
   terraform apply
   ```

---

This template is ready for you to customize and extend for your infrastructure needs. Happy automating!
