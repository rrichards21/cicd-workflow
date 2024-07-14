variable "env" {
  default     = "dev"
  description = "Nombre de ambiente"
}

variable "project_id" {
  default     = "<GCP_Project_ID>"
  description = "Id del proyecto en GCP"
}

variable "region" {
  default     = "us"
  description = "Region de GCP usada para el proyecto"
}

variable "bucket_name" {
  default     = "<GCP_bucket_name>
  description = "Nombre del bucket donde se aloja el container"
}