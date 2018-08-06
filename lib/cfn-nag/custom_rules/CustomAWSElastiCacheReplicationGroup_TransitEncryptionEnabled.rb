
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSElastiCacheReplicationGroup_TransitEncryptionEnabled < BaseRule
  def rule_text
    'AWS::ElastiCache::ReplicationGroup property [TransitEncryptionEnabled] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'encrypted-68'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElastiCache::ReplicationGroup').select do |resource|
      resource.transitencryptionenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        