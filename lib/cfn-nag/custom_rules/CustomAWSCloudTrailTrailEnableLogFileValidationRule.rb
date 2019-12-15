
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudTrailTrailEnableLogFileValidationRule < BaseRule
  def rule_text
    "[encryption_at_rest] AWS::CloudTrail::Trail property [EnableLogFileValidation] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0044'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudTrail::Trail').select do |resource|
      resource.enablelogfilevalidation.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        