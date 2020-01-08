
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudFormationMacroLogGroupNameRule < BaseRule
  def rule_text
    "[logging] AWS::CloudFormation::Macro property [LogGroupName] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0051'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudFormation::Macro').select do |resource|
      resource.loggroupname.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        