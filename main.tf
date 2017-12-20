variable "credentials" {
  description = "GCP credentials"
}

variable "gcp_project" {
  description = "GCP project name"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default = "us-east1"
}


provider "google" {
  credentials = "${var.credentials}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

resource "google_compute_network" "default" {
  name                    = "roger-berlind-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
  name    = "roger-berlind-firewall"
  network = "${google_compute_network.default.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["69.208.0.0/16"]
}
