
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElastiCacheReplicationGroupAutomaticFailoverEnabledRule < BaseRule
  def rule_text
    "[highavailability] AWS::ElastiCache::ReplicationGroup property [AutomaticFailoverEnabled] should exist, consider default values of [ True ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0131'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElastiCache::ReplicationGroup').select do |resource|
      resource.automaticfailoverenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        