
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSRedshiftCluster_Encrypted < BaseRule
  def rule_text
    'AWS::Redshift::Cluster property [Encrypted] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'encrypted-109'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Redshift::Cluster').select do |resource|
      resource.encrypted.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        