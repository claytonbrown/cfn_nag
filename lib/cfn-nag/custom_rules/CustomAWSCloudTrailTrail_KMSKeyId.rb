
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSCloudTrailTrail_KMSKeyId < BaseRule
  def rule_text
    'AWS::CloudTrail::Trail property [KMSKeyId] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'kms-encryption-key-10'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudTrail::Trail').select do |resource|
      resource.kmskeyid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        