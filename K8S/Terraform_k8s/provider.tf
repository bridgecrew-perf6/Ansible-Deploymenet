provider "google"{
    credentials=file("/home/raghu/terraform-key.json")
    project = var.project
    region = var.region
    zone = var.zone
}
