
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCodeBuildProjectEncryptionKeyRule < BaseRule
  def rule_text
    "[kms-encryption-key] AWS::CodeBuild::Project property [EncryptionKey] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0012'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CodeBuild::Project').select do |resource|
      resource.encryptionkey.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        