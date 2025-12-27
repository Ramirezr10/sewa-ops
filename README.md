![Build Status](https://github.com/Ramirezr10/sewa-ops/actions/workflows/deploy.yml/badge.svg)

Sewa-Ops: Secure Serverless-Edge Web Architecture

A production-ready CI/CD pipeline deploying a containerized Python application to Google Kubernetes Engine (GKE) Autopilot using Workload Identity Federation.
Code snippet

graph TD
    subgraph GitHub
        A[GitHub Repo] -->|Push| B(GitHub Actions)
    end

    subgraph "Google Cloud"
        B -->|OIDC Auth| C{Workload Identity}
        C -->|Token| D[Artifact Registry]
        B -->|Push Image| D
        B -->|Deploy| E[GKE Autopilot]
        E -->|Pull| D
    end

    F[User] -->|Web Traffic| G[Load Balancer]
    G --> E

🚀 Features

    Keyless Authentication: Uses OpenID Connect (OIDC) to eliminate the need for long-lived GCP Service Account JSON keys.

    Infrastructure as Code: VPC and GKE Autopilot managed via Terraform.

    Automated GitOps: GitHub Actions builds Docker images, pushes to Artifact Registry, and performs dynamic manifest substitution for GKE deployments.

🛠 Tech Stack

    Cloud: Google Cloud Platform (GCP)

    Orchestration: GKE Autopilot

    CI/CD: GitHub Actions

    Infrastructure: Terraform

    Containerization: Docker & Artifact Registry

    App: Flask (Python)

🔐 Security Highlights

This project implements Workload Identity Federation (WIF). GitHub Actions acts as a trusted identity provider, exchanging a short-lived OIDC token for temporary GCP credentials.

    Least Privilege: The GitHub runner only has permissions to push to Artifact Registry and connect to GKE.

    No Secrets: No Google Service Account JSON keys are stored in GitHub Secrets, eliminating the risk of credential leakage.

🧠 Lessons Learned & Troubleshooting
1. Identity Claim Mapping (OIDC)

Challenge: Initial authentication failed due to strict attribute conditions. Solution: Learned that Workload Identity Pool provider attributes are case-sensitive. Corrected the CEL expression to match the exact GitHub repository owner case (Ramirezr10) and mapped the google.subject to the repository claim.
2. GKE Node-Level Permissions

Challenge: Pods were stuck in ImagePullBackOff even though the image existed in the registry. Solution: Identified that GKE Autopilot nodes use the Compute Engine default service account to pull images. Resolved by granting roles/artifactregistry.reader to the node's service account, bridging the gap between GKE and Artifact Registry.
3. Kubernetes Immutability

Challenge: Deployment updates failed with field is immutable errors on spec.selector. Solution: Transitioned from manual kubectl create commands to a fully declarative GitOps approach. Established a clean state by deleting legacy deployments and allowing GitHub Actions to manage the resource lifecycle via kubectl apply.
🛠 Setup & Usage

    Infra: Run terraform apply in the /terraform folder.

    Auth: Configure the Workload Identity Pool and Provider in GCP.

    CI/CD: Push code to main to trigger the build and deploy.

    Verify: Use kubectl get svc to find the external LoadBalancer IP.
