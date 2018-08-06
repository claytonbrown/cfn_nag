
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSEC2Instance_Tags < BaseRule
  def rule_text
    'AWS::EC2::Instance property [Tags] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-31'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::Instance').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        