
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSDMSEndpointKmsKeyIdRule < BaseRule
  def rule_text
    "[kms-encryption-key] AWS::DMS::Endpoint property [KmsKeyId] should exist, consider default values of [ {'Ref': 'KmsKeyId'} ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0041'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::DMS::Endpoint').select do |resource|
      resource.kmskeyid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        