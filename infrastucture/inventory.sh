#!/bin/bash

# clean the inventory file
echo "" > inventory
# Extract values from JSON output
MASTER=$(terraform output -json | jq -r '.load_balancer_node.value')
SLAVE_1=$(terraform output -json | jq -r '.server_1.value')
SLAVE_2=$(terraform output -json | jq -r '.server_2.value')


# create master group
echo "[load_balancer]" >> inventory
master="load_balancer ansible_host={MASTER} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ansible"
master=$(echo "$master" | sed "s/{MASTER}/$MASTER/g")
echo $master >> inventory


# create slave group
echo "[server]" >> inventory

slave_1="server_1 ansible_host={SLAVE_1} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ansible"
slave_1=$(echo "$slave_1" | sed "s/{SLAVE_1}/$SLAVE_1/g")
echo $slave_1 >> inventory

slave_2="server_2 ansible_host={SLAVE_2} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ansible"
slave_2=$(echo "$slave_2" | sed "s/{SLAVE_2}/$SLAVE_2/g")
echo $slave_2 >> inventory

