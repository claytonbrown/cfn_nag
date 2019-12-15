
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElasticLoadBalancingLoadBalancerConnectionDrainingPolicyRule < BaseRule
  def rule_text
    "[standards] AWS::ElasticLoadBalancing::LoadBalancer property [ConnectionDrainingPolicy] should exist, consider default values of [ {'Enabled': True} ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0158'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElasticLoadBalancing::LoadBalancer').select do |resource|
      resource.connectiondrainingpolicy.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        