package aws

# input = {
#     "user": "alice",
#     "action": "ec2:StartInstance"
#     "resource": "arn:aws:ec2:::instance/i78999879"
# }

# FirstStatement
allow {
    input.action = "iam:ChangePassword"
}

# SecondStatement
allow {
    input.action = "s3:ListAllMyBuckets"
}

# ThirdStatement
#  Use helpers to handle implicit OR in the AWS policy.
#  Below both 'actions_match' and 'resources_match' must be true.
allow {
    actions_match
    resources_match
}

# actions_match is true if input.action matches one in the list
actions_match {
    # iterate over the actions in the list
    actions = ["s3:List.*","s3:Get.*"]
    action = actions[_]
    # check if input.action matches an action
    regex.globs_match(input.action, action)
}

# resources_match is true if input.resource matches one in the list
resources_match {
    # iterate over the resources in the list
    resources = ["arn:aws:s3:::confidential-data","arn:aws:s3:::confidential-data/.*"]
    resource = resources[_]
    # check if input.resource matches a resource
    regex.globs_match(input.resource, resource)
}
