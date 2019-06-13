
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSLogsLogGroupLogGroupNameRule < BaseRule
  def rule_text
    "[logging] AWS::Logs::LogGroup property [LogGroupName] should exist"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0128'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Logs::LogGroup').select do |resource|
      resource.loggroupname.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        