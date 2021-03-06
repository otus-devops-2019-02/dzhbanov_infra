terraform {
  # Версия terraform
  required_version = ">=0.11, <0.12"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # ID проекта тест
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "ansible-host" {
  source          = "../modules/ansible-host"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone            = "${var.zone}"
  ansible-host_disk_image   = "${var.ansible-host_disk_image}"
  ansible_path = "${var.ansible_path}"
  # использую имедж с app
}


module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
