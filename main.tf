resource "google_project_service" "project" {
  service = "compute.googleapis.com"
}

resource "google_compute_instance" "gcelab" {
  name         = "gcelab"
  machine_type = "n1-standard-2"
  zone         = "us-central1-c"

  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = "10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "apt update && apt-get install nginx -y"
  }
}

resource "google_compute_instance" "gcelab2" {
  name         = "gcelab2"
  machine_type = "n1-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

}

resource "google_compute_firewall" "default" {
  name    = "allowhttp"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "default"
}