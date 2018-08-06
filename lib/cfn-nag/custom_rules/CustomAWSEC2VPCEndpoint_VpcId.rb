
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSEC2VPCEndpoint_VpcId < BaseRule
  def rule_text
    'AWS::EC2::VPCEndpoint property [VpcId] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'vpc-protection-50'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::VPCEndpoint').select do |resource|
      resource.vpcid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        