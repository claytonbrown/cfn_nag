
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSS3Bucket_BucketEncryption < BaseRule
  def rule_text
    'AWS::S3::Bucket property [BucketEncryption] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'encrypted-117'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::S3::Bucket').select do |resource|
      resource.bucketencryption.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        