data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

resource "ibm_cd_toolchain" "toolchain_instance" {
  name        = var.toolchain_name
  description = var.toolchain_description
  resource_group_id = data.ibm_resource_group.resource_group.id
}

output "toolchain_id" {
  value = ibm_cd_toolchain.toolchain_instance.id
}

data "ibm_resource_instance" "testacc_ds_resource_instance" {
  name              = "us-stage-cd-key-protect"
  # location          = "global"
  resource_group_id = data.ibm_resource_group.resource_group.id
  # service           = "key-protect"
}

resource "ibm_iam_authorization_policy" "s2sAuth1" {
  source_service_name         = "toolchain"
  source_resource_instance_id = ibm_cd_toolchain.toolchain_instance.id
  target_service_name         = "kms"
  target_resource_instance_id = data.ibm_resource_instance.testacc_ds_resource_instance.guid
  roles                       = ["Viewer", "ReaderPlus"]
}

resource "ibm_cd_toolchain_tool_keyprotect" "cd_toolchain_tool_keyprotect" {
  depends_on = [
    ibm_iam_authorization_policy.s2sAuth1
  ]
  parameters {
        name = "kp-us-stage"
        region = "us-south"
        resource_group = data.ibm_resource_group.resource_group.id
        instance_name = "us-stage-cd-key-protect"
  }
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
}

data "ibm_cd_toolchain" "cd_toolchain_existing" {
    toolchain_id = "a9fac9b5-a59b-4dd2-95d5-ab0dbd69b5e4"
}

data "ibm_cd_toolchain_tool_hashicorpvault" "cd_toolchain_tool_hashicorpvault" {
    tool_id = "18391b87-a30a-493f-8b5a-9f4d2b892e6e"
    toolchain_id = data.ibm_cd_toolchain.cd_toolchain_existing.id
}

# data "ibm_kms_key" "test" {
#   instance_id = data.ibm_resource_instance.testacc_ds_resource_instance.guid
#   key_name = "kp-us-stage"
# }
//kms datasource for role_id, secret_id

resource "ibm_cd_toolchain_tool_hashicorpvault" "cd_toolchain_tool_hashicorpvault" {
  parameters {
        name = "hc-us-stage"
        server_url = "https://vserv-us.sos.ibm.com:8200"
        authentication_method = "approle"
        # role_id = 
        role_id = data.ibm_cd_toolchain_tool_hashicorpvault.cd_toolchain_tool_hashicorpvault.parameters[0].role_id
        secret_id = data.ibm_cd_toolchain_tool_hashicorpvault.cd_toolchain_tool_hashicorpvault.parameters[0].secret_id
        dashboard_url = "https://vserv-us.sos.ibm.com:8200/ui"
        path = "generic/crn/v1/staging/public/schematics/us-south/-/-/-/"
        #  path = "generic/crn/v1/staging/public/schematics/us-south/YS1/-/-/" another integration
  }
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
}

# data "ibm_cd_toolchain_tool_hostedgit" "cd_toolchain_tool_hostedgit" {
#     for_each = toset( ["ca943f29-8118-4c7f-bd7e-24fbd37f33cb", "a635e366-67ae-4468-bab7-da15dcfbdfe8", "821df31a-582d-474d-8149-9253defe3e97", "62d557fc-a215-4a4d-916a-f7add218b318", "047d5f9a-ced7-4364-a705-9e3078ab406a"] )
#     tool_id = each.key
#     toolchain_id = data.ibm_cd_toolchain.cd_toolchain_existing.id
# }

# data "ibm_cd_toolchain_tool_hostedgit" "cd_toolchain_tool_hostedgit" {
#     tool_id = "ca943f29-8118-4c7f-bd7e-24fbd37f33cb"
#     toolchain_id = data.ibm_cd_toolchain.cd_toolchain_existing.id
# }



resource "ibm_cd_toolchain_tool_githubintegrated" "cd_toolchain_tool_githubintegrated" {
  # for_each = toset(data.ibm_cd_toolchain_tool_hostedgit.cd_toolchain_tool_hostedgit)
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
  name         = "schematics-devops"
  initialization {
    # owner_id = "scmtxstg"
        repo_name = "schematics-devops"
        repo_url = "https://github.ibm.com/blueprint/schematics-devops"
        source_repo_url = "https://github.ibm.com/blueprint/schematics-devops"
        type = "new"
        private_repo = true
    # type = "clone"
    # private_repo = true
  }
  parameters {
    git_id = "scmtxstg"
        # api_root_url = "api_root_url"
        # owner_id = "owner_id"
        repo_name = "schematics-devops"
        repo_url = "https://github.ibm.com/blueprint/schematics-devops"
        source_repo_url = "https://github.ibm.com/blueprint/schematics-devops"
        # token_url = "token_url"
        type = "new"
        private_repo = true
    has_issues          = false
    enable_traceability = false
  }
}


# resource "ibm_cd_toolchain_tool_slack" "cd_toolchain_tool_slack" {
#   parameters {
#         api_token = "api_token"
#         channel_name = "schematics-build-pipelines"
#         team_url = "https://ibm-argonauts.slack.com"
#         pipeline_start = true
#         pipeline_success = true
#         pipeline_fail = true
#         toolchain_bind = true
#         toolchain_unbind = true
#   }
#   toolchain_id = ibm_cd_toolchain.toolchain_instance.id
# }


resource "ibm_cd_toolchain_tool_pipeline" "cd_toolchain_tool_pipeline" {
  parameters {
        name = "cd-pipeline"
        type = "tekton"
        ui_pipeline = true
  }
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
}

resource "ibm_cd_tekton_pipeline" "tekton_pipeline" {
  pipeline_id = ibm_cd_toolchain_tool_pipeline.cd_toolchain_tool_pipeline.tool_id
  worker {
        # id = "bko1vhhd0cgnhj8ebg40"
        id = "public"
  }
}

resource "ibm_cd_tekton_pipeline_definition" "pr_git_task_def" {
  pipeline_id   = ibm_cd_tekton_pipeline.tekton_pipeline.pipeline_id
  scm_source {
    url         = "https://github.ibm.com/blueprint/schematics-deploy"
    branch      = "master"
    path        = "jobs/network-policies/get-kube-policies-prod-us-south"
  }
}

resource "ibm_cd_tekton_pipeline_property" "tekton_pipeline_property1" {
  name = "REGION"
  pipeline_id = ibm_cd_tekton_pipeline.tekton_pipeline.pipeline_id
  type = "TEXT"
  value = "us-south"
}

resource "ibm_cd_tekton_pipeline_property" "tekton_pipeline_property2" {
  name = "ENVIRONMENT"
  pipeline_id = ibm_cd_tekton_pipeline.tekton_pipeline.pipeline_id
  type = "TEXT"
  value = "prod"
}

resource "ibm_cd_tekton_pipeline_property" "tekton_pipeline_property3" {
  name = "CLUSTERID"
  pipeline_id = ibm_cd_tekton_pipeline.tekton_pipeline.pipeline_id
  type = "TEXT"
  value = "bko1vhhd0cgnhj8ebg40"
}

resource "ibm_cd_tekton_pipeline_property" "tekton_pipeline_property4" {
  name = "RGROUP"
  pipeline_id = ibm_cd_tekton_pipeline.tekton_pipeline.pipeline_id
  type = "TEXT"
  value = "schematics-prod"
}

# resource "ibm_cd_tekton_pipeline_trigger" "tekton_pipeline_trigger" {
#   pipeline_id = ibm_cd_tekton_pipeline.tekton_pipeline.pipeline_id
#   trigger {
#         source_trigger_id = "source_trigger_id"
#         name = "start-deploy"
#   }
# }



resource "ibm_cd_toolchain_tool_devopsinsights" "devopsinsights_tool" {
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
}

# resource "ibm_cd_toolchain_tool_slack" "slack_tool" {
#   toolchain_id = ibm_cd_toolchain.toolchain_instance.id
#   parameters {
#     api_token = var.slack_api_token
#     channel_name = "schematics-build-pipelines"
#     team_url = var.slack_user_name
#   }
# }

resource "ibm_cd_toolchain_tool_custom" "cos_integration" {
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
  parameters {
      type = "cos-bucket"
      lifecycle_phase = "MANAGE"
      image_url = "https://github.ibm.com/open-toolchain/compliance-ci-toolchain/raw/master/.bluemix/cos-logo.png"
      documentation_url = "https://cloud.ibm.com/catalog/services/cloud-object-storage"
      name = "Cloud Object Storage"
      dashboard_url = "https://cloud.ibm.com/catalog/services/cloud-object-storage"
      description = "The information required to connect the toolchain with your Cloud Object Storage instance."
  }
}
