# 🚀 Terraform Multi-Environment AWS Infrastructure

> A multi-environment AWS infrastructure demonstration project using Terraform workspaces.

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

---

## 📋 Table of Contents

- [About The Project](#-about-the-project)
  - [Architecture](#-architecture)
  - [Environment Differences](#-environment-differences)
- [Getting Started](#-getting-started)
  - [Prerequisites](#-prerequisites)
  - [Local Usage](#-local-usage)
  - [GitHub Actions Usage](#-github-actions-usage)
- [Costs](#-costs)
- [Cleanup](#-cleanup)
- [Project Structure](#-project-structure)
- [License](#-license)
- [Contributing](#-contributing)

---

## 🎯 About The Project

This project demonstrates how to manage multi-environment AWS infrastructure using Terraform workspaces. It provides a complete, production-ready setup for deploying infrastructure across **dev**, **stage**, and **prod** environments with environment-specific configurations.

**Key Features:**
- ✅ Multi-environment support using Terraform workspaces
- ✅ Environment-specific security configurations
- ✅ Automated CI/CD with GitHub Actions
- ✅ AWS Free Tier compatible
- ✅ Infrastructure as Code best practices

### 🏗️ Architecture

This project creates a comprehensive, multi-environment AWS infrastructure:

| Component | Description |
|-----------|-------------|
| 🌐 **VPC** | Environment-specific CIDR blocks |
| 🔌 **Subnets** | 2 public subnets in each VPC |
| 🌍 **Internet Gateway** | Internet access for public subnets |
| 🛣️ **Route Tables** | Routing configuration |
| 🔒 **Security Groups** | Environment-specific security rules |
| 👤 **IAM Role** | For EC2 instances (SSM access, S3 read-only) |
| 💻 **EC2 Instances** | t3.micro instances with environment-specific count |
| 🪣 **S3 Bucket** | Environment-specific naming with encryption and versioning |

### 📊 Environment Differences

| Environment | VPC CIDR | Instance Count | SSH Access | Security Group |
|-------------|----------|----------------|------------|----------------|
| 🟢 **dev** | `10.0.0.0/16` | 1x t3.micro | From anywhere (0.0.0.0/0) | Permissive |
| 🟡 **stage** | `10.1.0.0/16` | 1x t3.micro | From specific IP | Moderately strict |
| 🔴 **prod** | `10.2.0.0/16` | 2x t3.micro | From VPN/bastion only | Strict |

---

## 🚀 Getting Started

### 📦 Prerequisites

Before you begin, ensure you have the following:

- ☁️ AWS account with active Free Tier
- 🛠️ Terraform >= 1.0 installed
- 🐙 GitHub account
- ⚙️ AWS CLI configured (optional, but recommended)

### 💻 Local Usage

#### 1️⃣ Clone and Setup

```bash
git clone https://github.com/joobadam/terraform-multi-env-aws.git
cd terraform-multi-env-aws
```

#### 2️⃣ Configure Terraform Variables

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
# Edit terraform.tfvars with your own values
```

#### 3️⃣ Initialize Terraform

```bash
cd terraform
terraform init
```

#### 4️⃣ Workspace Management

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

#### 5️⃣ Create Infrastructure

```bash
# Run plan
terraform plan

# Apply changes
terraform apply
```

#### 6️⃣ View Output Values

```bash
terraform output
```

### 🔄 GitHub Actions Usage

#### 1️⃣ Configure GitHub Secrets

In repository **Settings > Secrets and variables > Actions**, add:

- `AWS_ACCESS_KEY_ID`: AWS access key ID
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key

#### 2️⃣ Run Workflow

- 🤖 **Automatic**: Every push to main branch (when `terraform/**` paths change) runs plan
- 👆 **Manual**: Go to repository Actions tab, select "Terraform Deploy" workflow and run with desired environment

---

## 💰 Costs

This project uses only **AWS Free Tier** resources:

| Service | Free Tier Limit |
|---------|----------------|
| 💻 **EC2** | t3.micro instances (750 hours/month free) |
| 🪣 **S3** | Standard storage (5GB free) |
| 🌐 **VPC** | Free |
| 👤 **IAM** | Free |
| 📊 **CloudWatch** | Basic monitoring free |

> 💡 **Note**: The project can be run completely free within Free Tier limits.

---

## 🧹 Cleanup

To destroy infrastructure:

```bash
cd terraform
terraform workspace select <environment>
terraform destroy
```

> ⚠️ **Important**: Repeat the above steps for each workspace to clean up all environments.

---

## 📁 Project Structure

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

---

## 📄 License

Distributed under the MIT License. See `LICENSE` file for more information.

---

## 🤝 Contributing

This is a demonstration portfolio project. Feedback and suggestions are welcome!

If you have a suggestion that would make this better, please:
1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

<p align="right">(<a href="#-terraform-multi-environment-aws-infrastructure">back to top</a>)</p>