
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSEC2VPC_EnableDnsHostnames < BaseRule
  def rule_text
    'AWS::EC2::VPC property [EnableDnsHostnames] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'logging-45'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::VPC').select do |resource|
      resource.enablednshostnames.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        