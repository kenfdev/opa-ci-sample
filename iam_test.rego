package aws

test_change_password_action_allowed {
  allow with input as { "action": "iam:ChangePassword" }
}

test_s3_ListAllMyBuckets_allowed {
  allow with input as { "action": "s3:ListAllMyBuckets" }
}

test_s3_ListBucket_to_confidential_data_allowed {
  not allow with input as { 
    "action": "s3:ListBucket",
    "resource": "arn:aws:s3:::confidential-data/12345678"
  }
}

test_s3_CreateBucket_to_confidential_data_not_allowed {
  not allow with input as { 
    "action": "s3:CreateBucket",
    "resource": "arn:aws:s3:::confidential-data/12345678"
  }
}
