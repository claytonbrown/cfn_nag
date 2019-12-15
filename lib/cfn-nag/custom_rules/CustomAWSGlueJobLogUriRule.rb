
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSGlueJobLogUriRule < BaseRule
  def rule_text
    "[logging] AWS::Glue::Job property [LogUri] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0172'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Glue::Job').select do |resource|
      resource.loguri.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        