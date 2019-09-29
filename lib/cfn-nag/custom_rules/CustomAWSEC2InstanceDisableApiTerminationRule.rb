
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2InstanceDisableApiTerminationRule < BaseRule
  def rule_text
    "[standards] AWS::EC2::Instance property [DisableApiTermination] should exist, consider default values of [ False ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0077'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::Instance').select do |resource|
      resource.disableapitermination.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        