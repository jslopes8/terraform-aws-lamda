variable "create" {
    type    = bool
    default = true
}
variable "archive_file" {
    type    = any
    default = []
}
variable "function_name" {
    type    = string
    default = null
}
variable "handler" {
    type    = string
    default = null
}
variable "role" {
    type    = string
    default = null
}
variable "runtime" {
    type    = string
    default = null
}
variable "timeout" {
    type    = number
    default = "3"
}
variable "vpc_config" {
    type    = any
    default = []
}
variable "default_tags" {
    type    = map(string)
    default = {}
}
variable "description" {
    type    = string
    default = null
}
variable "lambda_permission" {
    type    = any
    default = []
}
variable "environment" {
    type    = any
    default = {}
}
variable "log_retention_in_days" {
    type = number
    default = "1"
}