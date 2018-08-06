
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSRDSDBCluster_StorageEncrypted < BaseRule
  def rule_text
    'AWS::RDS::DBCluster property [StorageEncrypted] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'encrypted-96'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::RDS::DBCluster').select do |resource|
      resource.storageencrypted.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        