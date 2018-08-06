
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElastiCacheCacheClusterTagsRule < BaseRule
  def rule_text
    "[taggable] AWS::ElastiCache::CacheCluster property [Tags] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0064'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElastiCache::CacheCluster').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        