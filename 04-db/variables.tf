variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Enviornment = "dev"
        Terraform = "true"
    }
}


variable "zone_name" {
    default = "neelareddy.store"
}
