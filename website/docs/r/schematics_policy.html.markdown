---
layout: "ibm"
page_title: "IBM : ibm_schematics_policy"
description: |-
  Manages schematics_policy.
subcategory: "Schematics Service API"
---

# ibm_schematics_policy

Provides a resource for schematics_policy. This allows schematics_policy to be created, updated and deleted.

## Example Usage

```hcl
resource "ibm_schematics_policy" "schematics_policy_instance" {
  description = "Policy for job execution of secured workspaces on agent1"
  name = "Agent1-DevWS"
  parameter {
		agent_assignment_policy_parameter {
			selector_kind = "ids"
			selector_ids = [ "selector_ids" ]
			selector_scope {
				kind = "workspace"
				tags = [ "tags" ]
				resource_groups = [ "resource_groups" ]
				locations = [ "us-south" ]
			}
		}
  }
  resource_group = "Default"
  scoped_resources {
		kind = "workspace"
		id = "id"
  }
  state {
		state = "draft"
		set_by = "set_by"
		set_at = "2021-01-31T09:44:12Z"
  }
  target {
		selector_kind = "ids"
		selector_ids = [ "selector_ids" ]
		selector_scope {
			kind = "workspace"
			tags = [ "tags" ]
			resource_groups = [ "resource_groups" ]
			locations = [ "us-south" ]
		}
  }
}
```

## Argument Reference

Review the argument reference that you can specify for your resource.

* `name` - (Required, String) Name of Schematics customization policy.
* `description` - (Optional, String) The description of Schematics customization policy.
* `kind` - (Optional, String) Policy kind or categories for managing and deriving policy decision  * `agent_assignment_policy` Agent assignment policy for job execution.
  * Constraints: Allowable values are: `agent_assignment_policy`.
* `location` - (Optional, String) List of locations supported by IBM Cloud Schematics service.  While creating your workspace or action, choose the right region, since it cannot be changed.  Note, this does not limit the location of the IBM Cloud resources, provisioned using Schematics.
  * Constraints: Allowable values are: `us-south`, `us-east`, `eu-gb`, `eu-de`.
* `parameter` - (Optional, List) The parameter to tune the Schematics policy.
Nested scheme for **parameter**:
	* `agent_assignment_policy_parameter` - (Optional, List) Parameters for the `agent_assignment_policy`.
	Nested scheme for **agent_assignment_policy_parameter**:
		* `selector_ids` - (Optional, List) The static selectors of schematics object ids (workspace, action or blueprint) for the Schematics policy.
		* `selector_kind` - (Optional, String) Types of schematics object selector.
		  * Constraints: Allowable values are: `ids`, `scoped`.
		* `selector_scope` - (Optional, List) The selectors to dynamically list of schematics object ids (workspace, action or blueprint) for the Schematics policy.
		Nested scheme for **selector_scope**:
			* `kind` - (Optional, String) Name of the Schematics automation resource.
			  * Constraints: Allowable values are: `workspace`, `action`, `system`, `environment`, `blueprint`.
			* `locations` - (Optional, List) The location based selector.
			  * Constraints: Allowable list items are: `us-south`, `us-east`, `eu-gb`, `eu-de`.
			* `resource_groups` - (Optional, List) The resource group based selector.
			* `tags` - (Optional, List) The tag based selector.
* `resource_group` - (Optional, String) The resource group name for the policy.  By default, Policy will be created in `default` Resource Group.
* `scoped_resources` - (Optional, List) List of scoped Schematics resources targeted by the policy.
Nested scheme for **scoped_resources**:
	* `id` - (Optional, String) Schematics resource Id.
	* `kind` - (Optional, String) Name of the Schematics automation resource.
	  * Constraints: Allowable values are: `workspace`, `action`, `system`, `environment`, `blueprint`.
* `state` - (Optional, List) User defined status of the Schematics object.
Nested scheme for **state**:
	* `set_at` - (Computed, String) When the User who set the state of the Object.
	* `set_by` - (Computed, String) Name of the User who set the state of the Object.
	* `state` - (Optional, String) User-defined states  * `draft` Object can be modified; can be used by Jobs run by the author, during execution  * `live` Object can be modified; can be used by Jobs during execution  * `locked` Object cannot be modified; can be used by Jobs during execution  * `disable` Object can be modified. cannot be used by Jobs during execution.
	  * Constraints: Allowable values are: `draft`, `live`, `locked`, `disable`.
* `tags` - (Optional, List) Tags for the Schematics customization policy.
* `target` - (Optional, List) The objects for the Schematics policy.
Nested scheme for **target**:
	* `selector_ids` - (Optional, List) Static selectors of schematics object ids (agent, workspace, action or blueprint) for the Schematics policy.
	* `selector_kind` - (Optional, String) Types of schematics object selector.
	  * Constraints: Allowable values are: `ids`, `scoped`.
	* `selector_scope` - (Optional, List) Selectors to dynamically list of schematics object ids (agent, workspace, action or blueprint) for the Schematics policy.
	Nested scheme for **selector_scope**:
		* `kind` - (Optional, String) Name of the Schematics automation resource.
		  * Constraints: Allowable values are: `workspace`, `action`, `system`, `environment`, `blueprint`.
		* `locations` - (Optional, List) The location based selector.
		  * Constraints: Allowable list items are: `us-south`, `us-east`, `eu-gb`, `eu-de`.
		* `resource_groups` - (Optional, List) The resource group based selector.
		* `tags` - (Optional, List) The tag based selector.

## Attribute Reference

In addition to all argument references listed, you can access the following attribute references after your resource is created.

* `id` - The unique identifier of the schematics_policy.
* `account` - (String) The Account id.
* `created_at` - (String) The policy creation time.
* `created_by` - (String) The user who created the policy.
* `crn` - (String) The policy CRN.
* `updated_at` - (String) The policy updation time.

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

You can import the `ibm_schematics_policy` resource by using `id`. The system generated policy Id.

# Syntax
```
$ terraform import ibm_schematics_policy.schematics_policy <id>
```
