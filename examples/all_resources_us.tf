terraform {
  # Require Terraform version 0.15.x (recommended)
  required_version = "~> 0.15.0"

  required_providers {
    site24x7 = {
      source  = "site24x7/site24x7"
      
      // Uncomment for local setup
      # source  = "registry.zoho.io/zoho/site24x7"
      # 
    #   source  = "registry.terraform.io/site24x7/site24x7"
    #   
    }
  }
}

// Authentication API doc - https://www.site24x7.com/help/api/#authentication
provider "site24x7" {
  // (Required) The client ID will be looked up in the SITE24X7_OAUTH2_CLIENT_ID
  // environment variable if the attribute is empty or omitted.
  # oauth2_client_id = "<SITE24X7_OAUTH2_CLIENT_ID>"

  // (Required) The client secret will be looked up in the SITE24X7_OAUTH2_CLIENT_SECRET
  // environment variable if the attribute is empty or omitted.
  # oauth2_client_secret = "<SITE24X7_OAUTH2_CLIENT_SECRET>"

  // (Required) The refresh token will be looked up in the SITE24X7_OAUTH2_REFRESH_TOKEN
  // environment variable if the attribute is empty or omitted.
  # oauth2_refresh_token = "<SITE24X7_OAUTH2_REFRESH_TOKEN>"

  // ZAAID of the customer under a MSP or BU
  zaaid = "1234"

  // (Required) Specify the data center from which you have obtained your
  // OAuth client credentials and refresh token. It can be (US/EU/IN/AU/CN).
  data_center = "US"

  // The minimum time to wait in seconds before retrying failed Site24x7 API requests.
  retry_min_wait = 1

  // The maximum time to wait in seconds before retrying failed Site24x7 API
  // requests. This is the upper limit for the wait duration with exponential
  // backoff.
  retry_max_wait = 30

  // Maximum number of Site24x7 API request retries to perform until giving up.
  max_retries = 4

}

// Site24x7 Tag API doc - https://www.site24x7.com/help/api/#tags
resource "site24x7_tag" "tag_us" {
  // (Required) Display Name for the Tag.
  tag_name = "Website Tag - Terraform"

  // Value for the Tag.
  tag_value = "Zoho Domains - Terraform"

  // Color code for the Tag. Possible values are '#B7DA9E','#73C7A3','#B5DCDF','#D4ABBB','#4895A8','#DFE897','#FCEA8B','#FFC36D','#F79953','#F16B3C','#E55445','#F2E2B6','#DEC57B','#CBBD80','#AAB3D4','#7085BA','#F6BDAE','#EFAB6D','#CA765C','#999','#4A148C','#009688','#00ACC1','#0091EA','#8BC34A','#558B2F'
  tag_color = "#B7DA9E"
}

// Site24x7 Location Profile API doc - https://www.site24x7.com/help/api/#location-profiles
resource "site24x7_location_profile" "location_profile_us" {
  // (Required) Display name for the location profile.
  profile_name = "Location Profile - Terraform"

  // (Required) Primary location for monitoring.
  primary_location = "20"

  // (Optional) List of secondary locations for monitoring.
  secondary_locations = [
    "106",
	  "8",
	  "113",
	  # "94"
  ]

  // (Optional) Restricts polling of the resource from the selected locations alone in the Location Profile, overrides the alternate location poll logic.
  restrict_alternate_location_polling = true
}

// Website Monitor API doc: https://www.site24x7.com/help/api/#website
resource "site24x7_website_monitor" "website_monitor_example" {
  // (Required) Display name for the monitor
  display_name = "Example Monitor"

  // (Required) Website address to monitor.
  website = "https://www.example.com"

  // (Optional) Interval at which your website has to be monitored.
  // See https://www.site24x7.com/help/api/#check-interval for all supported values.
  check_frequency = "1"

  // (Optional) Name of the Location Profile that has to be associated with the monitor. 
  // Either specify location_profile_id or location_profile_name.
  // If location_profile_id and location_profile_name are omitted,
  // the first profile returned by the /api/location_profiles endpoint
  // (https://www.site24x7.com/help/api/#list-of-all-location-profiles) will be
  // used.
  location_profile_name = "North America"

  // (Optional) Map of custom HTTP headers to send.
  custom_headers = {
    "Accept" = "application/json"
  }

  // (Optional) Map of HTTP response headers to check.
  response_headers_severity = 0 // Can take values 0 or 2. '0' denotes Down and '2' denotes Trouble.
  response_headers = {
    "Content-Encoding" = "gzip"
    "Connection" = "Keep-Alive"
  }
  third_party_service_ids = [
    "4567"
  ]
}

// Website Monitor API doc: https://www.site24x7.com/help/api/#website
resource "site24x7_website_monitor" "web_monitor_us" {
  // (Required) Display name for the monitor
  display_name = "Web Monitor "

  // (Required) Website address to monitor.
  website = "https://www.example.com"

  // (Optional) Interval at which your website has to be monitored.
  // See https://www.site24x7.com/help/api/#check-interval for all supported values.
  check_frequency = "1"

  // (Optional) Name of the Location Profile that has to be associated with the monitor. 
  // Either specify location_profile_id or location_profile_name.
  // If location_profile_id and location_profile_name are omitted,
  // the first profile returned by the /api/location_profiles endpoint
  // (https://www.site24x7.com/help/api/#list-of-all-location-profiles) will be
  // used.
  location_profile_name = "North America"

  // (Optional) Map of custom HTTP headers to send.
  custom_headers = {
    "Accept" = "application/json"
  }

  // (Optional) Map of HTTP response headers to check.
  response_headers_severity = 0 // Can take values 0 or 2. '0' denotes Down and '2' denotes Trouble.
  response_headers = {
    "Content-Encoding" = "gzip"
    "Connection" = "Keep-Alive"
  }
  // (Optional) List of Third Party Service IDs to be associated to the monitor.
  third_party_service_ids = [
    "4567"
  ]
}

// Site24x7 SSL Certificate Monitor API doc - https://www.site24x7.com/help/api/#ssl-certificate
resource "site24x7_ssl_monitor" "ssl_monitor_us" {
  // (Required) Display name for the monitor
  display_name = "Example SSL Monitor"
  // (Required) Domain name to be verified for SSL Certificate.
  domain_name = "www.example.com"
  // (Optional) Name of the Location Profile that has to be associated with the monitor. 
  // Either specify location_profile_id or location_profile_name.
  // If location_profile_id and location_profile_name are omitted,
  // the first profile returned by the /api/location_profiles endpoint
  // (https://www.site24x7.com/help/api/#list-of-all-location-profiles) will be
  // used.
  location_profile_name = "North America"
  # // (Optional) List if tag IDs to be associated to the monitor.
  # tag_ids = [
  #   "123",
  # ]
  // (Optional) List of Third Party Service IDs to be associated to the monitor.
  third_party_service_ids = [
    "4567"
  ]
}

// Site24x7 Rest API Monitor API doc - https://www.site24x7.com/help/api/#rest-api
resource "site24x7_rest_api_monitor" "rest_api_monitor_us" {
  // (Required) Display name for the monitor
  display_name = "REST API - terraform"
  // (Required) Website address to monitor.
  website = "https://dummy.restapiexample.com/"
  // (Optional) Name of the Location Profile that has to be associated with the monitor. 
  // Either specify location_profile_id or location_profile_name.
  // If location_profile_id and location_profile_name are omitted,
  // the first profile returned by the /api/location_profiles endpoint
  // (https://www.site24x7.com/help/api/#list-of-all-location-profiles) will be
  // used.
  location_profile_name = "North America"
  // (Optional) Check for the keyword in the website response.
  matching_keyword = {
 	  severity= 2
 	  value= "aaa"
 	}
  // (Optional) Check for non existence of keyword in the website response.
  unmatching_keyword = {
 	  severity= 2
 	  value= "bbb"
 	}
  // (Optional) Match the regular expression in the website response.
  match_regex = {
 	  severity= 2
 	  value= ".*aaa.*"
 	}
  // (Optional) List if tag IDs to be associated to the monitor.
  # tag_ids = [
  #   "123",
  # ]

  // (Optional) List of Third Party Service IDs to be associated to the monitor.
  third_party_service_ids = [
    "4567"
  ]

  // (Optional) Map of custom HTTP headers to send.
  custom_headers = {
    "Accept" = "application/json"
  }

  // (Optional) Map of HTTP response headers to check.
  response_headers_severity = 0 // Can take values 0 or 2. '0' denotes Down and '2' denotes Trouble.
  response_headers = {
    "Content-Encoding" = "gzip"
    "Connection" = "Keep-Alive"
  }
}

// Site24x7 Amazon Monitor API doc - https://www.site24x7.com/help/api/#amazon-webservice-monitor
resource "site24x7_amazon_monitor" "aws_monitor_site24x7" {
  // (Required) Display name for the monitor
  display_name = "aws_added_via_terraform"
  // (Required) AWS access key
  aws_access_key = ""
  // (Required) AWS secret key
  aws_secret_key = ""
  // (Optional) AWS discover frequency
  aws_discovery_frequency = 5
  // (Optional) AWS services to discover. See https://www.site24x7.com/help/api/#aws_discover_services 
  // for knowing service ID.
  aws_discover_services = ["1"]
  // (Optional) List if tag IDs to be associated to the monitor.
  # tag_ids = [
  #   "123",
  # ]
  // (Optional) List of Third Party Service IDs to be associated to the monitor.
  third_party_service_ids = [
    "4567"
  ]
}

// Site24x7 notification profile doc - https://www.site24x7.com/help/api/#notification-profiles
resource "site24x7_notification_profile" "notification_profile_us" {
  // (Required) Display name for the notification profile.
  profile_name = "Notification Profile - Terraform"
}

// Site24x7 notification profile API doc - https://www.site24x7.com/help/api/#notification-profiles
resource "site24x7_notification_profile" "notification_profile_all_attributes_us" {
  // (Required) Display name for the notification profile.
  profile_name = "Notification Profile All Attributes - Terraform"

  // (Optional) Settings to send root cause analysis when monitor goes down. Default is true.
  rca_needed= true

  // (Optional) Settings to downtime only after executing configured monitor actions.
  notify_after_executing_actions = true

  // (Optional) Configuration for delayed notification. Default value is 1. Can take values 1, 2, 3, 4, 5.
  downtime_notification_delay = 2

  // (Optional) Settings to receive persistent notification after number of errors. Can take values 1, 2, 3, 4, 5.
  persistent_notification = 1

  // (Optional) User group ID for downtime escalation.
  escalation_user_group_id = "123456000000025005"

  // (Optional) Duration of Downtime before Escalation. Mandatory if any user group is added for escalation.
  escalation_wait_time = 30

  // (Optional) Email template ID for notification
  template_id = 123456000024578001

  // (Optional) Settings to stop an automation being executed on the dependent monitors.
  suppress_automation = true

  // (Optional) Execute configured IT automations during an escalation.
  escalation_automations = [
    "123456000000047001"
  ]

  // (Optional) Invoke and manage escalations in your preferred third party services.
  escalation_services = [
    "123456000008777001"
  ]
}



