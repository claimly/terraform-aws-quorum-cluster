# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "primary_region" {
  description = "The AWS region that single-region resources like the vault and consul clusters will be placed in."
}

variable "public_key" {
  description = "The public key that will be used to SSH the instances in this region."
}

variable "vote_threshold" {
  description = "The number of votes needed to confirm a block. This should be more than half of the number of validator nodes."
}

variable "min_block_time" {
  description = "The minimum number of seconds a block maker should wait between proposing blocks."
}

variable "max_block_time" {
  description = "The maximum number of seconds a block maker should wait between proposing blocks."
}

variable "vault_dns" {
  description = "The DNS name that vault will be accessible on."
}

variable "vault_cert_bucket_name" {
  description = "The name of the S3 bucket holding the vault TLS certificates"
}

variable "vault_cert_bucket_arn" {
  description = "The ARN of the S3 bucket holding the vault TLS certificates"
}

variable "consul_cluster_tag_key" {
  description = "The tag key of the consul cluster to use for vault cluster locking."
}

variable "consul_cluster_tag_value" {
  description = "The tag value of the consul cluster to use for vault cluster locking."
}

variable "vault_cert_s3_upload_id" {
  description = "Generated by quorum_vault after uploading certificates to S3. Used to work around lack of depends_on for modules."
}

variable "node_count_bucket_name" {
  description = "The name of the S3 bucket holding the node counts"
}

variable "node_count_bucket_arn" {
  description = "The ARN of the S3 bucket holding the node counts"
}

variable "node_count_s3_upload_id" {
  description = "Generated by a null_resource after uploading node_counts to S3. Used to work around lack of depends_on for modules."
}

variable "quorum_maker_cidrs" {
  description = "List of CIDR ranges for quorum maker nodes."
  type        = "list"
}

variable "quorum_validator_cidrs" {
  description = "List of CIDR ranges for quorum validator nodes."
  type        = "list"
}

variable "quorum_observer_cidrs" {
  description = "List of CIDR ranges for quorum observer nodes."
  type        = "list"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "network_id" {
  description = <<DESCRIPTION
Ethereum network ID, also used in naming some resources for uniqueness.
Must be unique amongst networks in the same AWS account and launched with this tool.
Ideally is globally unique amongst ethereum and quorum networks.
DESCRIPTION
  default = 64813
}

variable "private_key" {
  description = <<DESCRIPTION
SSH private key to be used for authentication.
Will use the agent if none is provided.
DESCRIPTION
  default     = ""
}

variable "backup_lambda_ssh_private_key_path" {
  description = <<DESCRIPTION
Path to SSH private key to be used for authentication by the BackupLambda function.
DESCRIPTION
  default     = ""
}

variable "backup_lambda_ssh_private_key" {
  description = <<DESCRIPTION
SSH private key to be used for authentication by the BackupLambda function.
DESCRIPTION
  default     = ""
}

variable "gas_limit" {
  description = "The limit on gas that can be used in a single block"
  default     = 804247552
}

variable "vault_port" {
  description = "The port that vault will be accessible on."
  default     = 8200
}

variable "force_destroy_s3_buckets" {
  description = "Whether or not to force destroy s3 buckets. Set to true for an easily destroyed test environment. DO NOT set to true for a production environment."
  default     = false
}

variable "s3_bucket_suffix" {
  description = "A suffix to add to the end of deterministic s3 bucket names."
  default     = ""
}

variable "generate_metrics" {
  description = "Whether or not to generate CloudWatch metrics from the cluster. Set to false to disable for cost savings."
  default     = true
}

variable "create_alarms" {
  description = "Whether or not to create CloudWatch alarms. They will not function if generate_metrics is false."
  default     = false
}

variable "use_dedicated_bootnodes" {
  description = "Whether or not to use dedicated instances for bootnodes."
  default     = false
}

variable "use_dedicated_makers" {
  description = "Whether or not to use dedicated instances for maker nodes."
  default     = false
}

variable "use_dedicated_validators" {
  description = "Whether or not to use dedicated instances for validator nodes."
  default     = false
}

variable "use_dedicated_observers" {
  description = "Whether or not to use dedicated instances for observer nodes."
  default     = false
}

variable "use_elastic_bootnode_ips" {
  description = "Whether or not to give bootnodes elastic IPs, maintaining one static IP forever. Disabled by default because regions with more than 5 nodes in one region using elastic IPs will require personally requesting more EIPs from AWS. WARNING: UNTESTED SINCE MOVING BOOTNODES INTO QUORUM VPC. MAY BE REMOVED IN A FUTURE UPDATE."
  default     = false
}

variable "use_elastic_observer_ips" {
  description = "Whether or not to give observers elastic IPs, maintaining one static IP forever. Disabled by default because clusters with more than 5 nodes in one region using elastic IPs will require personally requesting more EIPs from AWS."
  default     = false
}

variable "ssh_ips" {
  description = "List of IP addresses allowed to SSH nodes in this network. If empty, will allow SSH from anywhere."
  default     = []
}

variable "other_validator_connection_ips" {
  description = "List of IP addresses outside the network that validators are allowed to directly connect to."
  default     = []
}

variable "bootnode_instance_type" {
  description = "The EC2 instance type to use for bootnodes"
  default     = "t2.small"
}

variable "quorum_maker_instance_type" {
  description = "The EC2 instance type to use for maker nodes"
  default     = "t2.small"
}

variable "quorum_validator_instance_type" {
  description = "The EC2 instance type to use for validator nodes"
  default     = "t2.small"
}

variable "quorum_observer_instance_type" {
  description = "The EC2 instance type to use for observer nodes"
  default     = "t2.small"
}

variable "quorum_ami" {
  description = "AMI ID to use for quorum nodes. Defaults to getting the most recently built version from Eximchain"
  default     = ""
}

variable "bootnode_ami" {
  description = "AMI ID to use for quorum nodes. Defaults to getting the most recently built version from Eximchain"
  default     = ""
}

variable "quorum_vpc_cidr" {
  description = "CIDR range to use for the quorum VPC."
  default     = "10.0.0.0/16"
}

variable "node_volume_size" {
  description = "The size of the EBS volume for a quorum node in GB"
  default     = 20
}

variable "max_peers" {
  description = "The number of peers each node will accept."
  default     = 25
}

variable "threatstack_deploy_key" {
  description = "Deploy key to use to activate threatstack agents, if using one"
  default     = ""
}

variable "foxpass_base_dn" {
  description = "The Base DN for your Foxpass account, if managing SSH keys with Foxpass"
  default     = ""
}

variable "foxpass_bind_user" {
  description = "The bind user name for your Foxpass account, if managing SSH keys with Foxpass"
  default     = ""
}

variable "foxpass_bind_pw" {
  description = "The bind user password for your Foxpass account, if managing SSH keys with Foxpass"
  default     = ""
}

variable "foxpass_api_key" {
  description = "The API key for your Foxpass account, if managing SSH keys with Foxpass"
  default     = ""
}

variable "az_override" {
  description = "A Mapping from AWS region to a comma-separated string of AZs to use for that region. Overrides dynamically reading available AZs."
  default     = {}
}

variable "bootnode_counts" {
  description = "A mapping from region to the number of bootnodes to launch in that region"
  type        = "map"
  default     = {
    # Virginia
    us-east-1      = 0
    # Ohio
    us-east-2      = 0
    # California
    us-west-1      = 0
    # Oregon
    us-west-2      = 0
    # Frankfurt
    eu-central-1   = 0
    # Ireland
    eu-west-1      = 0
    # London
    eu-west-2      = 0
    # Mumbai
    ap-south-1     = 0
    # Tokyo
    ap-northeast-1 = 0
    # Seoul
    ap-northeast-2 = 0
    # Singapore
    ap-southeast-1 = 0
    # Sydney
    ap-southeast-2 = 0
    # Canada
    ca-central-1   = 0
    # South America
    sa-east-1      = 0
  }
}

variable "maker_node_counts" {
  description = "A mapping from region to the number of maker nodes to launch in that region"
  type        = "map"
  default     = {
    # Virginia
    us-east-1      = 0
    # Ohio
    us-east-2      = 0
    # California
    us-west-1      = 0
    # Oregon
    us-west-2      = 0
    # Frankfurt
    eu-central-1   = 0
    # Ireland
    eu-west-1      = 0
    # London
    eu-west-2      = 0
    # Mumbai
    ap-south-1     = 0
    # Tokyo
    ap-northeast-1 = 0
    # Seoul
    ap-northeast-2 = 0
    # Singapore
    ap-southeast-1 = 0
    # Sydney
    ap-southeast-2 = 0
    # Canada
    ca-central-1   = 0
    # South America
    sa-east-1      = 0
  }
}

variable "validator_node_counts" {
  description = "A mapping from region to the number of validator nodes to launch in that region"
  type        = "map"
  default     = {
    # Virginia
    us-east-1      = 0
    # Ohio
    us-east-2      = 0
    # California
    us-west-1      = 0
    # Oregon
    us-west-2      = 0
    # Frankfurt
    eu-central-1   = 0
    # Ireland
    eu-west-1      = 0
    # London
    eu-west-2      = 0
    # Mumbai
    ap-south-1     = 0
    # Tokyo
    ap-northeast-1 = 0
    # Seoul
    ap-northeast-2 = 0
    # Singapore
    ap-southeast-1 = 0
    # Sydney
    ap-southeast-2 = 0
    # Canada
    ca-central-1   = 0
    # South America
    sa-east-1      = 0
  }
}

variable "observer_node_counts" {
  description = "A mapping from region to the number of observer nodes to launch in that region"
  type        = "map"
  default     = {
    # Virginia
    us-east-1      = 0
    # Ohio
    us-east-2      = 0
    # California
    us-west-1      = 0
    # Oregon
    us-west-2      = 0
    # Frankfurt
    eu-central-1   = 0
    # Ireland
    eu-west-1      = 0
    # London
    eu-west-2      = 0
    # Mumbai
    ap-south-1     = 0
    # Tokyo
    ap-northeast-1 = 0
    # Seoul
    ap-northeast-2 = 0
    # Singapore
    ap-southeast-1 = 0
    # Sydney
    ap-southeast-2 = 0
    # Canada
    ca-central-1   = 0
    # South America
    sa-east-1      = 0
  }
}

variable "backup_lambda_binary" {
    default = "BackupLambda"
    description = "Name of BackupLambda binary"
}

variable "backup_lambda_binary_path" {
    default = "BackupLambda"
    description = "Full path to the binary for the BackupLambda"
}

variable "backup_lambda_binary_url" {
  description = <<DESCRIPTION
URL to retrieve the backup lambda binary.
DESCRIPTION
  default     = "https://github.com/EximChua/BackupLambda/releases/download/0.1/BackupLambda"
}

# this is the lambda zip, must be a relative path
# eg "BackupLambda.zip"
variable "backup_lambda_output_path" {
    default = "BackupLambda.zip"
    description = "Relative path to the BackupLambda zip"
}

# This is the full path to the private key 
# eg "/Users/xxxx/.ssh/cert"
variable "private_key_path" {
    default = ""
    description = "Full path to the private key to access Quorum nodes"
}

# This is the public key path
# eg "/Users/xxxx/.ssh/cert.pub"
variable "public_key_path" {
    default = ""
    description = "Full path to the public key for Quorum nodes"
}

# output prefix of encrypted SSH key, region will be appended to the filename
variable "enc_ssh_path" {
    default = "enc-ssh"
    description = "Full path to the encrypted SSH key to be generated, region will be appended to the filename"
}

# key on S3 bucket
variable "enc_ssh_key" {
    default = "enc-ssh"
    description = "The key to access the encrypted SSH key on the S3 bucket"
}

# If singular, it's 1 hour, 1 minute, 1 week, 1 day, etc.
variable "backup_interval" {
    default = ""
    description = "The schedule expression for the backup interval, see https://docs.aws.amazon.com/lambda/latest/dg/tutorial-scheduled-events-schedule-expressions.html for examples"
}
