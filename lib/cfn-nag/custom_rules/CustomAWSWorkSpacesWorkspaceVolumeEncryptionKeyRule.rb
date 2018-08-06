
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSWorkSpacesWorkspaceVolumeEncryptionKeyRule < BaseRule
  def rule_text
    "[kms-encryption-key] AWS::WorkSpaces::Workspace property [VolumeEncryptionKey] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0123'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::WorkSpaces::Workspace').select do |resource|
      resource.volumeencryptionkey.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        