
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2VPCPeeringConnectionVpcIdRule < BaseRule
  def rule_text
    "[vpc-protection] AWS::EC2::VPCPeeringConnection property [VpcId] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0053'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::VPCPeeringConnection').select do |resource|
      resource.vpcid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        