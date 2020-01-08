
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRDSDBSecurityGroupEC2VpcIdRule < BaseRule
  def rule_text
    "[vpc-protection] AWS::RDS::DBSecurityGroup property [EC2VpcId] should exist, consider default values of [ {'Ref': 'VpcId'} ]  [WA-sec_network_protection_layered]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0344'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::RDS::DBSecurityGroup').select do |resource|
      resource.ec2vpcid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        