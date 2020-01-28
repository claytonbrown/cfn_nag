
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSStepFunctionsStateMachineLoggingConfigurationRule < BaseRule
  def rule_text
    "[logging] AWS::StepFunctions::StateMachine property [LoggingConfiguration] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0409'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::StepFunctions::StateMachine').select do |resource|
      resource.loggingconfiguration.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        