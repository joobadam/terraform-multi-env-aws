# Terraform Multi-Environment AWS Infrastructure

A multi-environment AWS infrastructure demonstration project using Terraform workspaces.

## Architecture

This project creates a simple, multi-environment AWS infrastructure:

- **VPC**: Environment-specific CIDR blocks
- **Subnets**: 2 public subnets in each VPC
- **Internet Gateway**: Internet access
- **Route Tables**: Routing configuration
- **Security Groups**: Environment-specific security rules
- **IAM Role**: For EC2 instances (SSM access, S3 read-only)
- **EC2 Instances**: t3.micro instances with environment-specific count
- **S3 Bucket**: Environment-specific naming with encryption and versioning

## Environment Differences

| Environment | VPC CIDR | Instance Count | SSH Access | Security Group |
|-------------|----------|----------------|------------|----------------|
| **dev**     | 10.0.0.0/16 | 1x t3.micro | From anywhere (0.0.0.0/0) | Permissive |
| **stage**   | 10.1.0.0/16 | 1x t3.micro | From specific IP | Moderately strict |
| **prod**    | 10.2.0.0/16 | 2x t3.micro | From VPN/bastion only | Strict |

## Prerequisites

- AWS account with active Free Tier
- Terraform >= 1.0 installed
- GitHub account
- AWS CLI configured (optional)

## Local Usage

### 1. Clone and Setup

```bash
git clone https://github.com/joobadam/terraform-multi-env-aws.git
cd terraform-multi-env-aws
```

### 2. Configure Terraform Variables

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
# Edit terraform.tfvars with your own values
```

### 3. Initialize Terraform

```bash
cd terraform
terraform init
```

### 4. Workspace Management

```bash
# List workspaces
terraform workspace list

# Create new workspaces
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod

# Switch workspace
terraform workspace select dev
```

### 5. Create Infrastructure

```bash
# Run plan
terraform plan

# Apply changes
terraform apply
```

### 6. View Output Values

```bash
terraform output
```

## GitHub Actions Usage

### 1. Configure GitHub Secrets

In repository Settings > Secrets and variables > Actions, add:

- `AWS_ACCESS_KEY_ID`: AWS access key ID
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key

### 2. Run Workflow

- **Automatic**: Every push to main branch (when terraform/** paths change) runs plan
- **Manual**: Go to repository Actions tab, select "Terraform Deploy" workflow and run with desired environment

## Costs

This project uses only AWS Free Tier resources:

- **EC2**: t3.micro instances (750 hours/month free)
- **S3**: Standard storage (5GB free)
- **VPC**: Free
- **IAM**: Free
- **CloudWatch**: Basic monitoring free

The project can be run completely free within Free Tier limits.

## Cleanup

To destroy infrastructure:

```bash
cd terraform
terraform workspace select <environment>
terraform destroy
```

Repeat the above steps for each workspace to clean up all environments.

## Project Structure

```
terraform-multi-env-aws/
├── terraform/
│   ├── main.tf                    # Main infrastructure
│   ├── variables.tf               # Variables
│   ├── outputs.tf                 # Output values
│   ├── backend.tf                 # State backend configuration
│   └── terraform.tfvars.example   # Example variable file
├── .github/workflows/
│   └── deploy.yml                 # GitHub Actions workflow
└── README.md                      # Documentation
```

## License

MIT License - see LICENSE file for details.

## Contributing

This is a demonstration portfolio project. Feedback and suggestions are welcome!