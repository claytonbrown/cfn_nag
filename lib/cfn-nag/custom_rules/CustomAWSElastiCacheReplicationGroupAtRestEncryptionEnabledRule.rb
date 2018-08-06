
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSElastiCacheReplicationGroupAtRestEncryptionEnabledRule < BaseRule
  def rule_text
    "[encrypted] AWS::ElastiCache::ReplicationGroup property [AtRestEncryptionEnabled] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0065'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ElastiCache::ReplicationGroup').select do |resource|
      resource.atrestencryptionenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        