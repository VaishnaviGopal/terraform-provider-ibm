variable "resource_group" {
  type        = string
  description = "Resource group within which toolchain will be created"
  default     = "schematics-devops"
}

variable "region" {
  type        = string
  description = "IBM Cloud region where your toolchain will be created"
  default     = "us-south"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API KEY to interact with IBM Cloud"
  default = ""
}

variable "toolchain_name" {
  type        = string
  description = "Name of the Toolchain."
  default     = "devops-stage"
}

variable "toolchain_description" {
  type        = string
  description = "Description for the Toolchain."
  default     = "This toolchain is created to accommodate multiple pipelines for various tasks"
}

