# Sewa-Ops: Keyless GKE GitOps Pipeline

A production-ready CI/CD pipeline deploying a containerized Python application to Google Kubernetes Engine (GKE) Autopilot using **Workload Identity Federation**.

## 🚀 Features
- **Keyless Authentication:** Uses OpenID Connect (OIDC) to eliminate the need for long-lived GCP Service Account JSON keys.
- **Infrastructure as Code:** VPC and GKE Autopilot managed via Terraform.
- **Automated GitOps:** GitHub Actions builds Docker images, pushes to Artifact Registry, and deploys to GKE.

## 🛠 Tech Stack
- **Cloud:** Google Cloud Platform (GCP)
- **Orchestration:** GKE Autopilot
- **CI/CD:** GitHub Actions
- **Infrastructure:** Terraform
- **Containerization:** Docker & Artifact Registry

## 🔐 Security Highlights
This project avoids the "Leaked Key" risk by using **Workload Identity Federation**. GitHub Actions acts as a trusted identity provider, exchanging a short-lived OIDC token for temporary GCP credentials based on specific repository attributes.
