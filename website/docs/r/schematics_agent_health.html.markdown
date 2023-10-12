---
layout: "ibm"
page_title: "IBM : ibm_schematics_agent_health"
description: |-
  Manages schematics_agent_health.
subcategory: "Schematics Service API"
---

# ibm_schematics_agent_health

Provides a resource for schematics_agent_health. This allows schematics_agent_health to be created, updated and deleted.

## Example Usage

```hcl
resource "ibm_schematics_agent_health" "schematics_agent_health_instance" {
  agent_id = "agent_id"
}
```

## Argument Reference

Review the argument reference that you can specify for your resource.

* `agent_id` - (Required, Forces new resource, String) Agent ID to get the details of agent.
* `force` - (Optional, Boolean) Equivalent to -force options in the command line, default is false.

## Attribute Reference

In addition to all argument references listed, you can access the following attribute references after your resource is created.

* `id` - The unique identifier of the schematics_agent_health.
* `agent_version` - (String) Agent version.
* `job_id` - (String) Job Id.
* `log_url` - (String) URL to the full health-check job logs.
* `status_code` - (String) Final result of the health-check job.
  * Constraints: Allowable values are: `pending`, `in-progress`, `success`, `failed`.
* `status_message` - (String) The outcome of the health-check job, in a formatted log string.
* `updated_at` - (String) The agent health check job updation time.
* `updated_by` - (String) Email address of user who ran the agent health check job.

## Provider Configuration

The IBM Cloud provider offers a flexible means of providing credentials for authentication. The following methods are supported, in this order, and explained below:

- Static credentials
- Environment variables

To find which credentials are required for this resource, see the service table [here](https://cloud.ibm.com/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-provider-reference#required-parameters).

### Static credentials

You can provide your static credentials by adding the `ibmcloud_api_key`, `iaas_classic_username`, and `iaas_classic_api_key` arguments in the IBM Cloud provider block.

Usage:
```
provider "ibm" {
    ibmcloud_api_key = ""
    iaas_classic_username = ""
    iaas_classic_api_key = ""
}
```

### Environment variables

You can provide your credentials by exporting the `IC_API_KEY`, `IAAS_CLASSIC_USERNAME`, and `IAAS_CLASSIC_API_KEY` environment variables, representing your IBM Cloud platform API key, IBM Cloud Classic Infrastructure (SoftLayer) user name, and IBM Cloud infrastructure API key, respectively.

```
provider "ibm" {}
```

Usage:
```
export IC_API_KEY="ibmcloud_api_key" // pragma: allowlist secret
export IAAS_CLASSIC_USERNAME="iaas_classic_username" // pragma: allowlist secret
export IAAS_CLASSIC_API_KEY="iaas_classic_api_key" // pragma: allowlist secret
terraform plan
```

Note:

1. Create or find your `ibmcloud_api_key` and `iaas_classic_api_key` [here](https://cloud.ibm.com/iam/apikeys).
  - Select `My IBM Cloud API Keys` option from view dropdown for `ibmcloud_api_key`
  - Select `Classic Infrastructure API Keys` option from view dropdown for `iaas_classic_api_key`
2. For iaas_classic_username
  - Go to [Users](https://cloud.ibm.com/iam/users)
  - Click on user.
  - Find user name in the `VPN password` section under `User Details` tab

For more informaton, see [here](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs#authentication).

## Import

You can import the `ibm_schematics_agent_health` resource by using `agent_id`.
The `agent_id` property can be formed from `agent_id`, and `agent_id` in the following format:

```
<agent_id>/<agent_id>
```
* `agent_id`: A string. Agent ID to get the details of agent.
* `agent_id`: A string. Agent ID to get the details of agent.

# Syntax
```
$ terraform import ibm_schematics_agent_health.schematics_agent_health <agent_id>/<agent_id>
```
