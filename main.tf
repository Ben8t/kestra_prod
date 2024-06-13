terraform {
  required_providers {
    kestra = {
      source  = "kestra-io/kestra" # namespace of Kestra provider
      version = "~> 0.14.0"         # version of Kestra Terraform provider, not the version of Kestra
    }
  }
}

provider "kestra" {
  url = "http://localhost:8089"
  username = "benoit@kestra.io"
  password = "kestra"
}

resource "kestra_flow" "flows" {
  for_each  = fileset(path.module, "flows/shiny_rocks/*.yml")
  flow_id   = yamldecode(templatefile(each.value, {}))["id"]
  namespace = yamldecode(templatefile(each.value, {}))["namespace"]
  content   = templatefile(each.value, {})
}

resource "kestra_namespace_file" "scripts_marketing" {
  for_each = fileset(path.module, "scripts/marketing/**/*")
  namespace = "shiny_rocks.marketing"
  filename = "/${each.value}"
  content = file(each.value)
  depends_on = [kestra_flow.flows]
}

resource "kestra_namespace_file" "scripts_product" {
  for_each = fileset(path.module, "scripts/produce/**/*")
  namespace = "shiny_rocks.product"
  filename = "/${each.value}"
  content = file(each.value)
  depends_on = [kestra_flow.flows]
}

resource "kestra_namespace_file" "scripts_sales" {
  for_each = fileset(path.module, "scripts/sales/**/*")
  namespace = "shiny_rocks.sales"
  filename = "/${each.value}"
  content = file(each.value)
  depends_on = [kestra_flow.flows]
}