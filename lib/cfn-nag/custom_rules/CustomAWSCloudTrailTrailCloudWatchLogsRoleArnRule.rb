
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudTrailTrailCloudWatchLogsRoleArnRule < BaseRule
  def rule_text
    "[logging] AWS::CloudTrail::Trail property [CloudWatchLogsRoleArn] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0007'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudTrail::Trail').select do |resource|
      resource.cloudwatchlogsrolearn.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        