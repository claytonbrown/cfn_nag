
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSLogsLogStreamLogStreamNameRule < BaseRule
  def rule_text
    "[logging] AWS::Logs::LogStream property [LogStreamName] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0202'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Logs::LogStream').select do |resource|
      resource.logstreamname.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        