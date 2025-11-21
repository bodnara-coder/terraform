# Configure the Google Cloud Provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Define the Rocky Linux e2-micro VM
resource "google_compute_instance" "rocky_vm" {
  name         = "rocky-tf-runner"
  machine_type = "e2-micro"
  zone         = "${var.region}-b" # US-east1-b is a valid zone for us-east1

  # Use the latest Rocky Linux image
  boot_disk {
    initialize_params {
      image = "rocky-linux-8-v20230712" # Check Google's public image list for the current latest
      size  = 10 # 10 GB disk is sufficient
      type  = "pd-standard"
    }
  }

  # Configure a simple network interface
  network_interface {
    network = "default" # Use the default VPC network
    access_config {
      # Ephemeral public IP address
    }
  }

  # Assign the service account to the VM instance (optional, but good practice)
  service_account {
    email  = google_service_account.vm_sa.email # Assuming you define a SA for the VM
    scopes = ["cloud-platform"]
  }
}

# Output the IP address for easy access
output "vm_external_ip" {
  value = google_compute_instance.rocky_vm.network_interface[0].access_config[0].nat_ip
}
