
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSOpsWorksStack_VpcId < BaseRule
  def rule_text
    'AWS::OpsWorks::Stack property [VpcId] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'vpc-protection-94'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::OpsWorks::Stack').select do |resource|
      resource.vpcid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        