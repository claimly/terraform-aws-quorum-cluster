output "quorum_vpc_id" {
  value = "${length(aws_vpc.quorum_cluster.*.id) != 0 ? element(concat(aws_vpc.quorum_cluster.*.id, list("")), 0) : ""}"
}

output "quorum_maker_node_dns" {
  value = "${data.aws_instance.quorum_maker_node.*.public_dns}"
}

output "quorum_validator_node_dns" {
  value = "${data.aws_instance.quorum_validator_node.*.public_dns}"
}

output "quorum_observer_node_dns" {
  value = "${data.aws_instance.quorum_observer_node.*.public_dns}"
}

output "bootnode_ips" {
  value = "${coalescelist(aws_eip.bootnodes.*.public_ip, data.aws_instance.bootnodes.*.public_ip)}"
}

output "quorum_cidr_block" {
  value = "${data.template_file.quorum_cidr_block.rendered}"
}

output "bootnode_cidr_block" {
  value = "${data.template_file.bootnode_cidr_block.rendered}"
}

output "quorum_maker_cidr_block" {
  value = "${data.template_file.quorum_maker_cidr_block.rendered}"
}

output "quorum_validator_cidr_block" {
  value = "${data.template_file.quorum_validator_cidr_block.rendered}"
}

output "quorum_observer_cidr_block" {
  value = "${data.template_file.quorum_observer_cidr_block.rendered}"
}
