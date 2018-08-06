
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRoute53HostedZoneQueryLoggingConfigRule < BaseRule
  def rule_text
    "[logging] AWS::Route53::HostedZone property [QueryLoggingConfig] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0116'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Route53::HostedZone').select do |resource|
      resource.queryloggingconfig.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        