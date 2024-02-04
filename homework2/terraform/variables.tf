variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "mage-data-prep"
}

variable "credentials" {
  description = "My GCP credentials"
  default     = "/home/nerdless/de-course-412517-66c29960b993.json"
}

variable "container_cpu" {
  description = "Container cpu"
  default     = "2000m"
}

variable "container_memory" {
  description = "Container memory"
  default     = "2G"
}

variable "project_id" {
  type        = string
  description = "The name of the project"
  default     = "de-course-412517"
}

variable "region" {
  type        = string
  description = "The default compute region"
  default     = "us-west2"
}

variable "zone" {
  type        = string
  description = "The default compute zone"
  default     = "us-west2-a"
}

variable "repository" {
  type        = string
  description = "The name of the Artifact Registry repository to be created"
  default     = "mage-data-prep"
}

variable "database_user" {
  type        = string
  description = "The username of the Postgres database."
  default     = "mageuser"
}

variable "database_password" {
  type        = string
  description = "The password of the Postgres database."
  sensitive   = true
}

variable "docker_image" {
  type        = string
  description = "The docker image to deploy to Cloud Run."
  default     = "mageai/mageai:latest"
}

variable "domain" {
  description = "Domain name to run the load balancer on. Used if `ssl` is `true`."
  type        = string
  default     = ""
}

variable "ssl" {
  description = "Run load balancer on HTTPS and provision managed certificate with provided `domain`."
  type        = bool
  default     = false
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "terraform-demo-bucket-h1"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "US"
}