
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSWorkSpacesWorkspace_VolumeEncryptionKey < BaseRule
  def rule_text
    'AWS::WorkSpaces::Workspace property [VolumeEncryptionKey] should exist and be {"Ref": "KmsKeyId"}'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-106'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::WorkSpaces::Workspace').select do |resource|
      resource.volumeencryptionkey.nil? || resource.volumeencryptionkey.to_s.downcase != '{"ref": "kmskeyid"}'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        