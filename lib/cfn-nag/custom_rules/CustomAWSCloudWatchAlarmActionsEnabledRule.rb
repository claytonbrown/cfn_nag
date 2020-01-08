
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudWatchAlarmActionsEnabledRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::CloudWatch::Alarm property [ActionsEnabled] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0064'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudWatch::Alarm').select do |resource|
      resource.actionsenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        