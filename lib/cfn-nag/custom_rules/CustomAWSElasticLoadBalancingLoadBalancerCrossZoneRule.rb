
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElasticLoadBalancingLoadBalancerCrossZoneRule < BaseRule
  def rule_text
    "[standards] AWS::ElasticLoadBalancing::LoadBalancer property [CrossZone] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0202'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElasticLoadBalancing::LoadBalancer').select do |resource|
      resource.crosszone.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        