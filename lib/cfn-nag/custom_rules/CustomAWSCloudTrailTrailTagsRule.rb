
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudTrailTrailTagsRule < BaseRule
  def rule_text
    "[taggable] AWS::CloudTrail::Trail property [Tags] should exist, consider default values of [ [{'Key': 'app_version', 'Value': {'Ref': 'TagsAppVersion'}}, {'Key': 'compliance', 'Value': {'Ref': 'TagsCompliance'}}, {'Key': 'confidentiality', 'Value': {'Ref': 'TagsConfidentiality'}}, {'Key': 'cost_code', 'Value': {'Ref': 'TagsCostCode'}}, {'Key': 'cost_owner', 'Value': {'Ref': 'TagsOwner'}}, {'Key': 'environment', 'Value': {'Ref': 'TagsEnvironment'}}, {'Key': 'kms_encryption_key', 'Value': {'Ref': 'TagsKMSKeyArn'}}, {'Key': 'logging_bucket', 'Value': {'Ref': 'TagsLoggingBucket'}}, {'Key': 'owner_email', 'Value': {'Ref': 'TagsOwnerEmail'}}] ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0011'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudTrail::Trail').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        