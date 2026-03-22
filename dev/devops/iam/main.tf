resource "google_project_iam_member" "developer_roles" {
  for_each = {
    for pair in setproduct(var.developers, var.roles) :
    "${pair[0]}-${pair[1]}" => {
      user = pair[0]
      role = pair[1]
    }
  }

  project = var.project_id
  role    = each.value.role
  member  = "user:${each.value.user}"
}
