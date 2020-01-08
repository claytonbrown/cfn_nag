
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSOpsWorksStackVpcIdRule < BaseRule
  def rule_text
    "[vpc-protection] AWS::OpsWorks::Stack property [VpcId] should exist, consider default values of [ {'Ref': 'VpcId'} ]  [WA-sec_network_protection_layered]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0287'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::OpsWorks::Stack').select do |resource|
      resource.vpcid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        