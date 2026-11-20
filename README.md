# ☁️ Azure & Kubernetes Infrastructure with Terraform (`terraform-azure-kub-floci`)

![Terraform](https://shields.io)
![Azure](https://shields.io)
![Kubernetes](https://shields.io)

## 🎯 Project Purpose
This repository serves as a hands-on engineering showcase demonstrating end-to-end **Infrastructure-as-Code (IaC)** workflows across **Azure**, **Terraform**, and **Kubernetes**. Rather than relying on monolithic scripts, this project implements industry-standard modular design and environment separation to provision scalable, repeatable cloud infrastructure.

---

## 🏗️ Architectural & Engineering Highlights
* **DRY Modular Design (`modules/`):** Abstracted core cloud resources into reusable, composable Terraform modules to minimize code duplication and simplify maintenance.
* **Multi-Environment Isolation (`Environments/`):** Structured configurations to support isolated lifecycles (e.g., Dev, Staging, Prod) with distinct variable sets.
* **Automated Kubernetes Orchestration:** End-to-end cluster provisioning and worker node configuration automated via Terraform.
* **Clean Configuration Management:** Follows Terraform best practices by separating input variables (`variables.tf`), computed values (`locals.tf`), provider locks (`provider.tf`), and resource exports (`output.tf`).

---

## 📂 Repository Structure
```text
terraform-azure-kub-floci/
├── Environments/       # Environment-specific configurations & tfvars
├── modules/            # Reusable Terraform infrastructure & K8s modules
├── main.tf             # Core resource orchestration
├── variables.tf        # Input variable definitions
├── locals.tf           # Local expressions and naming conventions
├── output.tf           # Exported resource attributes & cluster endpoints
└── provider.tf         # Azure & Kubernetes provider configurations
```

---

## 🛠️ Skills & Concepts Demonstrated
* **Infrastructure as Code (Terraform):** Module authoring, variable parameterization, dependency management, and declarative state workflows.
* **Container Orchestration (Kubernetes):** Cluster bootstrapping, networking setup, and declarative workload readiness.
* **Cloud Architecture (Azure):** Managed Identities & RBAC, Virtual Networks (VNet), Network Security Groups (NSGs), and AKS cluster provisioning

---

## 🚀 Quick Start / Usage

```bash
# 1. Clone the repository
# Clone via HTTPS
git clone https://github.com/AnupJacob/terraform-azure-kub-floci.git
OR
# clone via SSH
git clone git@github.com:AnupJacob/terraform-azure-kub-floci.git

cd terraform-azure-kub-floci

# 2. Initialize Terraform & download providers
terraform init

# 3. Review the execution plan
terraform plan

# 4. Provision the Azure infrastructure & Kubernetes cluster
terraform apply
```
