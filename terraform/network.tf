resource "google_compute_network" "main" {
  name                    = "main-vpc"
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnet"
  ip_cidr_range = "10.0.0.0/18"
  region        = var.region
  network       = google_compute_network.main.id

  # Enabling Private Google Access
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"
  }

  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20"
  }

}
