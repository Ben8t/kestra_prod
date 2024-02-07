terraform {
  required_providers {
    kestra = {
      source  = "kestra-io/kestra" # namespace of Kestra provider
      version = "~> 0.13.0"         # version of Kestra Terraform provider, not the version of Kestra
    }
  }
}

provider "kestra" {
  url = "http://localhost:8089"
  username = "benoit@kestra.io"
  password = "kestra"
}

resource "kestra_flow" "flows" {
  for_each  = fileset(path.module, "flows/*/*.yml")
  flow_id   = yamldecode(templatefile(each.value, {}))["id"]
  namespace = yamldecode(templatefile(each.value, {}))["namespace"]
  content   = templatefile(each.value, {})
  keep_original_source = true
}


resource "kestra_namespace_file" "test_script" {
  namespace = "demo.kestra.script"
  filename  = "/src/test.py"
  content   = file("scripts/test.py")
}

resource "kestra_namespace_file" "scripts_project_b" {
  for_each = fileset(path.module, "scripts/project_b/**/*.py")
  namespace = "demo.kestra.script.project_b"
  filename = "/${each.value}"
  content = file(each.value)
}

resource "kestra_namespace_file" "shiny_rocks" {
  for_each = fileset(path.module, "scripts/shiny_rocks/**/*")
  namespace = "shiny_rocks.sales"
  filename = "/${each.value}"
  content = file(each.value)
}