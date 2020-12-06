data "google_compute_image" "node"{
    name = "ubuntu-1804-bionic-v20201014"
    project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "node-k8s"{
    name = "node-k8s"
    metadata_startup_script = file("startup.sh")
    machine_type= "g1-small"
    boot_disk{
        initialize_params{
         image = data.google_compute_image.node.self_link
         size = 10
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
        command = "echo [k8s_worker] >> ../Inventory/inventory.txt"
    }
    provisioner "local-exec"{
        command = "echo node ansible_ssh_host=${google_compute_instance.node-k8s.network_interface.0.access_config.0.nat_ip} >> /tmp/Ansible/Main-Devops-Ansible/K8S/Inventory/inventory.txt"
    }
}