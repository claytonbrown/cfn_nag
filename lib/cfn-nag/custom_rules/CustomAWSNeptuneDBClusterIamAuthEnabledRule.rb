
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSNeptuneDBClusterIamAuthEnabledRule < BaseRule
  def rule_text
    "[standards] AWS::Neptune::DBCluster property [IamAuthEnabled] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0193'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Neptune::DBCluster').select do |resource|
      resource.iamauthenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        