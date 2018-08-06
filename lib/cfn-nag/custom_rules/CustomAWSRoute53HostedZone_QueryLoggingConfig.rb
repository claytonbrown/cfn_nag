
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSRoute53HostedZone_QueryLoggingConfig < BaseRule
  def rule_text
    'AWS::Route53::HostedZone property [QueryLoggingConfig] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-116'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Route53::HostedZone').select do |resource|
      resource.queryloggingconfig.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        