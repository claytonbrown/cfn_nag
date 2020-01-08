
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElasticLoadBalancingV2ListenerSslPolicyRule < BaseRule
  def rule_text
    "[standards] AWS::ElasticLoadBalancingV2::Listener property [SslPolicy] should exist, consider default values of [ ELBSecurityPolicy-TLS-1-2-Ext-2018-06 ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0203'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElasticLoadBalancingV2::Listener').select do |resource|
      resource.sslpolicy.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        