public_key_path           = "~/.ssh/quorum.pub"
private_key_path          = "~/.ssh/quorum"
cert_owner                = "FIXME_USER"
key_name                  = "quorum-cluster"
aws_region                = "us-east-1"
network_id                = 64813
force_destroy_s3_buckets  = true
vault_cluster_size        = 1
vault_instance_type       = "t2.small"
consul_cluster_size       = 1
consul_instance_type      = "t2.small"
bootnode_cluster_size     = 1
bootnode_instance_type    = "t2.small"
quorum_node_instance_type = "t2.medium"
num_maker_nodes           = 1
num_validator_nodes       = 1
num_observer_nodes        = 1
vote_threshold            = 1
