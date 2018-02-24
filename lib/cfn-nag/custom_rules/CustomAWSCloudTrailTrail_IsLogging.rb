
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSCloudTrailTrail_IsLogging < BaseRule
  def rule_text
    ''
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-7'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudTrail::Trail').select do |resource|
      resource.islogging.nil? || resource.islogging.to_s.downcase != 'true'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        