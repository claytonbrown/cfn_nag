
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSEC2VPC_EnableDnsHostnames < BaseRule
  def rule_text
    ''
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-41'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::VPC').select do |resource|
      resource.enablednshostnames.nil? || resource.enablednshostnames.to_s.downcase != 'true'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        