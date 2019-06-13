
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudTrailTrailCloudWatchLogsLogGroupArnRule < BaseRule
  def rule_text
    "[logging] AWS::CloudTrail::Trail property [CloudWatchLogsLogGroupArn] should exist"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0021'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudTrail::Trail').select do |resource|
      resource.cloudwatchlogsloggrouparn.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        