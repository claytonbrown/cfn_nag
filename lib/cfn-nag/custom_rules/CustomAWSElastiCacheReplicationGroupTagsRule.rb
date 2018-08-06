
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElastiCacheReplicationGroupTagsRule < BaseRule
  def rule_text
    "[taggable] AWS::ElastiCache::ReplicationGroup property [Tags] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0067'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElastiCache::ReplicationGroup').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        