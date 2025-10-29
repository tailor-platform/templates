resource "tailor_tailordb" "prj_mgmt_db" {
  workspace_id = var.workspace_id
  namespace    = "project-management-db"
}

resource "tailor_tailordb_type" "user" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  name         = "User"
  description  = "User of the system."

  fields = {
    name = {
      type        = "string"
      description = "Name of the user."
      index       = true
      required    = true
    }
    email = {
      type        = "string"
      description = "Email of the user."
      required    = true
    }
    roles = {
      type        = "string"
      description = "Roles of the user."
      array       = true
    }
  }
}

resource "tailor_tailordb_gql_permission" "user" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  type         = tailor_tailordb_type.user.name
  policies = [{
    actions     = ["all"]
    permit      = "allow"
    description = "allow all actions for everyone"
  }]
}

resource "tailor_tailordb_type" "project" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  name         = "Project"
  description  = "Project Description"
  fields = {
    name = {
      type        = "string"
      description = "Name of the project"
      index       = true
      required    = true
    }
    description = {
      type        = "string"
      description = "Description of the project"
    }
    status = {
      type        = "enum"
      description = "Status of the project"
      allowed_values = [
        {
          value       = "PLANNING"
          description = "PLANNING type"
        },
        {
          value       = "IN_PROGRESS"
          description = "IN_PROGRESS type"
        },
        {
          value       = "ON_HOLD"
          description = "ON_HOLD type"
        },
        {
          value       = "COMPLETED"
          description = "COMPLETED type"
        },
        {
          value       = "CANCELED"
          description = "CANCELED type"
        },
        {
          value       = "CLOSED"
          description = "CLOSED type"
        }
      ]
    }
    startDate = {
      type        = "datetime"
      description = "Start date"
    }
    endDate = {
      type        = "datetime"
      description = "End date"
    }
    createdAt = {
      type        = "datetime"
      description = "Creation date"
      hooks = {
        create = "(new Date()).toISOString()"
      }
    }
    updatedAt = {
      type        = "datetime"
      description = "Last updated date"
      hooks = {
        update = "(new Date()).toISOString()"
      }
    }
  }

  relationships = {
    task = {
      ref_type    = "Task"
      ref_field   = "projectId"
      src_field   = "id"
      array       = true
      description = "Link to the Task"
    }
  }
}

resource "tailor_tailordb_gql_permission" "project" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  type         = tailor_tailordb_type.project.name
  policies = [{
    actions     = ["all"]
    permit      = "allow"
    description = "allow all actions for everyone"
  }]
}

resource "tailor_tailordb_type" "task" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  name         = "Task"
  description  = "Task Description"
  fields = {
    name = {
      type        = "string"
      description = "Name of the task"
      index       = true
      required    = true
    }
    description = {
      type        = "string"
      description = "Description of the task"
    }
    status = {
      type        = "enum"
      description = "Status of the task"
      allowed_values = [
        {
          value       = "TODO"
          description = "TODO type"
        },
        {
          value       = "IN_PROGRESS"
          description = "IN_PROGRESS type"
        },
        {
          value       = "IN_REVIEW"
          description = "IN_REVIEW type"
        },
        {
          value       = "DONE"
          description = "DONE type"
        },
        {
          value       = "CANCELED"
          description = "CANCELED type"
        }
      ]
    }
    dueDate = {
      type        = "datetime"
      description = "Due date"
      required    = true
    }
    assigneeId = {
      type        = "uuid"
      description = "ID of the User"
    }
    projectId = {
      type        = "uuid"
      description = "ID of the Project"
      index       = true
    }
    createdAt = {
      type        = "datetime"
      description = "Creation date"
      hooks = {
        create = "(new Date()).toISOString()"
      }
    }
    updatedAt = {
      type        = "datetime"
      description = "Last updated date"
      hooks = {
        update = "(new Date()).toISOString()"
      }
    }
  }
  relationships = {
    user = {
      ref_type    = "User"
      ref_field   = "id"
      src_field   = "assigneeId"
      description = "Link to the User"
    }
    project = {
      ref_type    = "Project"
      ref_field   = "id"
      src_field   = "projectId"
      description = "Link to the Project"
    }
  }
}

resource "tailor_tailordb_gql_permission" "task" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  type         = tailor_tailordb_type.task.name
  policies = [{
    actions     = ["all"]
    permit      = "allow"
    description = "allow all actions for everyone"
  }]
}
