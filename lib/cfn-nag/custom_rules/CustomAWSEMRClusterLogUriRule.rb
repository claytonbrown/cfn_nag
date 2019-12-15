
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEMRClusterLogUriRule < BaseRule
  def rule_text
    "[logging] AWS::EMR::Cluster property [LogUri] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0141'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EMR::Cluster').select do |resource|
      resource.loguri.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        