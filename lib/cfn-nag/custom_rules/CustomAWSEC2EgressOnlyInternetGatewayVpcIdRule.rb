
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2EgressOnlyInternetGatewayVpcIdRule < BaseRule
  def rule_text
    "[vpc-protection] AWS::EC2::EgressOnlyInternetGateway property [VpcId] should exist, consider default values of [ {'Ref': 'VpcId'} ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0054'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::EgressOnlyInternetGateway').select do |resource|
      resource.vpcid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        