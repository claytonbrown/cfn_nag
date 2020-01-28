
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSS3BucketBucketEncryptionRule < BaseRule
  def rule_text
    "[encrypted] AWS::S3::Bucket property [BucketEncryption] should exist, consider default values of [ {'ServerSideEncryptionConfiguration': {'KMSMasterKeyID': {'Ref': 'KmsKeyId'}, 'SSEAlgorithm': 'aws:kms'}} ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0372'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::S3::Bucket').select do |resource|
      resource.bucketencryption.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        