# addx-take-home

This repository provisions **AWS infrastructure** using **Terraform**, builds and deploys a **Node.js API** to **Amazon EKS**, and manages deployment through **GitHub Actions**.

The API uses **PostgreSQL on Amazon RDS** and is exposed via **AWS ALB Ingress**.

---

## ✅ **Architecture**
- **AWS VPC**: Public & Private Subnets, NAT Gateway
- **EKS**: Private node group with IRSA enabled
- **ECR**: Stores Docker images for Node.js API
- **RDS (PostgreSQL)**: Private subnet database
- **ALB Ingress**: Public access for API
- **Node.js API**:
    - `/users` → List all users
    - `/users/:id` → Fetch a single user

---

## ✅ **Repository Structure**
addx-take-home/
├── README.md
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── provider.tf
│ └── modules/
│ ├── vpc/
│ ├── eks/
│ ├── rds/
│ ├── ecr/
│ └── alb_ingress/
├── nodejs-app/
│ ├── Dockerfile
│ ├── package.json
│ ├── server.js
│ └── .env.example
├── k8s/
│ ├── deployment.yaml
│ ├── service.yaml
│ ├── ingress.yaml
│ ├── serviceaccount.yaml
│ └── secret.yaml
└── .github/workflows/
├── terraform.yml
├── build-node.yml
└── k8s-deploy.yml

---

## ✅ **GitHub Actions Workflows**
We split CI/CD into **three separate workflows** for clarity and control:

---

### **1. Terraform Infrastructure**
File: `.github/workflows/terraform.yml`  
Purpose:
- Provision AWS infrastructure (VPC, EKS, RDS, ECR, ALB)
- Manage using Terraform with remote backend

**Trigger:** Manual via GitHub Actions → **Run Workflow**  
**Inputs:**
- `apply` → Deploy infrastructure
- `destroy` → Remove all resources

---

### **2. Build & Push Node.js Image**
File: `.github/workflows/build-node.yml`  
Purpose:
- Build Docker image for Node.js API
- Push to Amazon ECR

**Trigger:** Manual (after Terraform provisioning or on main branch update)

---

### **3. Deploy Kubernetes Manifests**
File: `.github/workflows/k8s-deploy.yml`  
Purpose:
- Update kubeconfig for EKS
- Create Kubernetes Secrets for DB creds
- Apply Deployment, Service, Ingress

**Trigger:** Manual (after image build)

---

## ✅ **How to Use**
### **Step 1: Configure GitHub Secrets**
Go to **Settings → Secrets and variables → Actions**, and add:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `DB_USER`
- `DB_PASSWORD`

---

### **Step 2: Run Workflows in Order**
1. **Terraform Infrastructure**
    - Action: `apply` → Creates all AWS resources
    - Output: `eks_cluster_name`, `rds_endpoint`, `alb_dns`
2. **Build & Push Node.js Image**
    - Builds Docker image and pushes to ECR
3. **Deploy Kubernetes Manifests**
    - Creates secrets in Kubernetes
    - Applies Deployment, Service, Ingress
    - Retrieves **ALB DNS** from AWS

---

### **Step 3: Test API**
Get ALB DNS:
```bash
kubectl get ingress nodejs-api-ingress

curl http://<ALB-DNS>/users
curl http://<ALB-DNS>/users/1
