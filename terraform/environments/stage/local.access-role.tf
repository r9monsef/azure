locals {
  users = {

    "reza" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpwdBmFM2qoqKDfMf5VIMTx6U9KeMj7GW6qKGEMAuZ0RTg79Q9vi1aY+vx47fjC2RDaoEYg8tEbYLTR/XSz9ycwZxfHGCko6Pu6i13aqufAC+SKXXFh3JLKoIUsqYL5DUSozgZ9a1kI2gXgIotHJHj3HvNI8xqjOQ6cwzsi6cWloo4jrMdmPBCgH/7LFUBQDfusBSRNfQ12KvHrg/TSqpx10ODQdDm86HVjhe9MAEpnLr2T9LEtW6iOvzmSibg6TJogtHzjQwzcA9zOXLZVgnIFsE8wo1XCn99KVkj9Wfg9UMxy6DR386wYNVn7OHj0Vs3neyIWPhe16dYkggwR8gz1IKYJOau2LmvuQFFJxSn/yRdm6svr9Xg1znp0QnLEJVziFI9TXWhLQ3VoWUiSHaNfbIYZs0Ui19m0RkwjXOKOqQeQ+eBlf9dm5pUFjurjgTN23Wk88ELeuA6p3WTSUA73XRCYz6HWHwrhALSpgAMwg1IVHRX5D0giL+zd6B1zpk= root@laptop"

  }

  role_members = {
    web = ["reza"]
    db  = ["reza"]
  }

  ssh_keys_by_role = {
    for role, members in local.role_members :
    role => [for u in members : local.users[u]]
  }
}
