
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSOpsWorksLayer_EnableAutoHealing < BaseRule
  def rule_text
    'AWS::OpsWorks::Layer property [EnableAutoHealing] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'logging-91'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::OpsWorks::Layer').select do |resource|
      resource.enableautohealing.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        