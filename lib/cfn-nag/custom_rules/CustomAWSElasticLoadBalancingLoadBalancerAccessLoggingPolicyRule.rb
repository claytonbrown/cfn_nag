
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElasticLoadBalancingLoadBalancerAccessLoggingPolicyRule < BaseRule
  def rule_text
    "[logging] AWS::ElasticLoadBalancing::LoadBalancer property [AccessLoggingPolicy] should exist"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0128'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElasticLoadBalancing::LoadBalancer').select do |resource|
      resource.accessloggingpolicy.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        