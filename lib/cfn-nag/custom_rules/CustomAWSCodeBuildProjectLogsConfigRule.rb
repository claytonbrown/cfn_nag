
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCodeBuildProjectLogsConfigRule < BaseRule
  def rule_text
    "[standards] AWS::CodeBuild::Project property [LogsConfig] should exist, consider default values of [ {'GroupName': 'TODO', 'Status': 'ENABLED', 'StreamName': 'TODO'} ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0068'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CodeBuild::Project').select do |resource|
      resource.logsconfig.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        