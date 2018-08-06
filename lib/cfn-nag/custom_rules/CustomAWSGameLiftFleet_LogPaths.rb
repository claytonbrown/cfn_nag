
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSGameLiftFleet_LogPaths < BaseRule
  def rule_text
    'AWS::GameLift::Fleet property [LogPaths] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'logging-76'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::GameLift::Fleet').select do |resource|
      resource.logpaths.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        