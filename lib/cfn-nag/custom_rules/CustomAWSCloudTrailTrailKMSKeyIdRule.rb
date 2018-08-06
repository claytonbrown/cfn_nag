
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudTrailTrailKMSKeyIdRule < BaseRule
  def rule_text
    "[kms-encryption-key] AWS::CloudTrail::Trail property [KMSKeyId] should exist, consider default values of [ {'Ref': 'KmsKeyId'} ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0010'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudTrail::Trail').select do |resource|
      resource.kmskeyid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        