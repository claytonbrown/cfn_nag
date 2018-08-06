
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSEMRCluster_LogUri < BaseRule
  def rule_text
    'AWS::EMR::Cluster property [LogUri] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'logging-62'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EMR::Cluster').select do |resource|
      resource.loguri.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        