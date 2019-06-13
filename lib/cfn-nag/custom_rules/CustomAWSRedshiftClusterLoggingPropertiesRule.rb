
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRedshiftClusterLoggingPropertiesRule < BaseRule
  def rule_text
    "[logging] AWS::Redshift::Cluster property [LoggingProperties] should exist"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0168'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Redshift::Cluster').select do |resource|
      resource.loggingproperties.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        