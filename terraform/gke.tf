resource "google_container_cluster" "primary" {
  name     = "autopilot-cluster"
  location = var.region

  #This is the "Free Tier" friendly mode
  enable_autopilot = true

  network    = google_compute_network.main.name
  subnetwork = google_compute_subnetwork.private.name

  # Essential for security/compliance roles
  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  deletion_protection = false

}

# Artifact Registry for your Docker images
resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "project-images"
  format        = "DOCKER"

}
