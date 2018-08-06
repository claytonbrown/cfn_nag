
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRDSDBInstanceKmsKeyIdRule < BaseRule
  def rule_text
    "[kms-encryption-key] AWS::RDS::DBInstance property [KmsKeyId] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0100'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::RDS::DBInstance').select do |resource|
      resource.kmskeyid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        