
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElastiCacheCacheClusterPreferredAvailabilityZonesRule < BaseRule
  def rule_text
    "[zone-specific] AWS::ElastiCache::CacheCluster property [PreferredAvailabilityZones] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0187'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElastiCache::CacheCluster').select do |resource|
      resource.preferredavailabilityzones.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        