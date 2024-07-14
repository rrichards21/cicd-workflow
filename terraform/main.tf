terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
  backend "gcs" {
    bucket  = var.bucket_name
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = "us"
}