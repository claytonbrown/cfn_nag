
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2SecurityGroupVpcIdRule < BaseRule
  def rule_text
    "[vpc-protection] AWS::EC2::SecurityGroup property [VpcId] should exist, consider default values of [ {'Ref': 'VpcId'} ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0083'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::SecurityGroup').select do |resource|
      resource.vpcid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        