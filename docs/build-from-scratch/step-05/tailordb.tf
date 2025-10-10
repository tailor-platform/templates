resource "tailor_tailordb" "prj_mgmt_db" {
  workspace_id = var.workspace_id
  namespace    = "project-management-db"
}

resource "tailor_tailordb_type" "role" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  name         = "Role"
  description  = "User roles."

  fields = {
    name = {
      type        = "string"
      description = "Name of the Role."
      index       = true
      required    = true
	  }
  }
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
      type        = "uuid"
      description = "Role IDs of the user."
      array       = true
	  }
  }
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
        type        = "string"
        description = "Status of the project"
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
  
}

resource "tailor_tailordb_type" "task" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt_db.namespace
  name         = "Task"
  description  = "Task Description"
  settings = {
    publish_record_events = true
  }
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
      type        = "string"
      description = "Status of the task"
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