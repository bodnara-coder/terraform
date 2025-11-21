variable "project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "region" {
  description = "The region for the VM instance (must be US-east1 for free tier eligibility)."
  type        = string
  default     = "us-east1"
}
