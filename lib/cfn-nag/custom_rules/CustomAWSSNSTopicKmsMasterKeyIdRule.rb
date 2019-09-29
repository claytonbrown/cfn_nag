
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSSNSTopicKmsMasterKeyIdRule < BaseRule
  def rule_text
    "[kms-encryption-key] AWS::SNS::Topic property [KmsMasterKeyId] should exist, consider default values of [ {'Ref': 'KmsKeyId'} ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0263'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::SNS::Topic').select do |resource|
      resource.kmsmasterkeyid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        