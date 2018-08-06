
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSRDSDBCluster_KmsKeyId < BaseRule
  def rule_text
    'AWS::RDS::DBCluster property [KmsKeyId] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'kms-encryption-key-95'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::RDS::DBCluster').select do |resource|
      resource.kmskeyid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        