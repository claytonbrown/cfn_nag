
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElasticLoadBalancingV2TargetGroupHealthCheckEnabledRule < BaseRule
  def rule_text
    "[standards] AWS::ElasticLoadBalancingV2::TargetGroup property [HealthCheckEnabled] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0143'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElasticLoadBalancingV2::TargetGroup').select do |resource|
      resource.healthcheckenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        