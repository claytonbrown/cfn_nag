
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2VPCEndpointVpcEndpointTypeRule < BaseRule
  def rule_text
    "[Private Networking] AWS::EC2::VPCEndpoint property [VpcEndpointType] should exist, consider default values of [ {'Ref': 'TODO'} ]  [WA-sec_network_protection_layered]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0157'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::VPCEndpoint').select do |resource|
      resource.vpcendpointtype.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        