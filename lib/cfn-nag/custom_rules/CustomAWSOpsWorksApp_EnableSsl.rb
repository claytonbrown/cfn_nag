
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSOpsWorksApp_EnableSsl < BaseRule
  def rule_text
    'AWS::OpsWorks::App property [EnableSsl] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'encrypted-88'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::OpsWorks::App').select do |resource|
      resource.enablessl.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        