data "google_compute_image" "master"{
    name= "ubuntu-1804-bionic-v20201014"
    project="ubuntu-os-cloud"
}

resource "google_compute_instance" "master-k8s"{
    name = "master-k8s"
    metadata_startup_script = file("startup.sh")
    machine_type = "e2-small"
    zone = var.zone
    boot_disk {
        initialize_params{
            image = data.google_compute_image.master.self_link
            size=10
        }
    }
    network_interface{
        network = var.network
        access_config{

        }
    }
    
    scheduling{
        preemptible = true
        automatic_restart = false
    }
    provisioner "local-exec"{
        command = "echo [k8s_master] >> ../Inventory/inventory.txt"
    }
    provisioner "local-exec" {
        command = "echo master ansible_ssh_host=${google_compute_instance.master-k8s.network_interface.0.access_config.0.nat_ip}  >> ../Inventory/inventory.txt "
    }
}
