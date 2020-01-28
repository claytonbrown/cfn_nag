
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSOpsWorksLayerEnableAutoHealingRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::OpsWorks::Layer property [EnableAutoHealing] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0289'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::OpsWorks::Layer').select do |resource|
      resource.enableautohealing.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        