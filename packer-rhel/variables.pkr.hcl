variable "subscription_id" {
  type    = string
  default = "<YOUR_AZURE_SUBSCRIPTION_ID>"
}

variable "resource_group" {
  type    = string
  default = "<YOUR_RESOURCE_GROUP_NAME>"
}

variable "location" {
  type    = string
  default = "southcentralus"
}

variable "gallery_name" {
  type    = string
  default = "<YOUR_COMPUTE_GALLERY_NAME>"
}

variable "image_version" {
  type        = string
  description = "The dynamic version of the image injected by GitHub Actions"
  default     = "1.0.0"
}
