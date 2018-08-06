
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSGameLiftFleetLogPathsRule < BaseRule
  def rule_text
    "[logging] AWS::GameLift::Fleet property [LogPaths] should exist"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0076'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::GameLift::Fleet').select do |resource|
      resource.logpaths.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        