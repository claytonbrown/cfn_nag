
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSRDSDBInstance_StorageEncrypted < BaseRule
  def rule_text
    'AWS::RDS::DBInstance property [StorageEncrypted] should exist and be True'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-88'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::RDS::DBInstance').select do |resource|
      resource.storageencrypted.nil? || resource.storageencrypted.to_s.downcase != 'true'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        