data "template_file" "sample" {
  template = "${file("${path.module}/template.txt")}"
  vars {
    valid_terraform_variable = "lorem ipsum"
  }
}

data "external" "uname" {
  program = ["${path.module}/echo-uname-json.sh"]
}

locals {
  uname = "${lower(data.external.uname.result["uname"])}"
}

resource "local_file" "sample" {
  filename = "rendered.txt.${local.uname}"
  content  = "${data.template_file.sample.rendered}"
}
