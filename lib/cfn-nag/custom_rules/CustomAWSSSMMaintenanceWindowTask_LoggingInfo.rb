
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSSSMMaintenanceWindowTask_LoggingInfo < BaseRule
  def rule_text
    'AWS::SSM::MaintenanceWindowTask property [LoggingInfo] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-120'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::SSM::MaintenanceWindowTask').select do |resource|
      resource.logginginfo.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        