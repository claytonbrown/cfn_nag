
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSWorkSpacesWorkspace_UserVolumeEncryptionEnabled < BaseRule
  def rule_text
    'AWS::WorkSpaces::Workspace property [UserVolumeEncryptionEnabled] should exist and be True'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-105'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::WorkSpaces::Workspace').select do |resource|
      resource.uservolumeencryptionenabled.nil? || resource.uservolumeencryptionenabled.to_s.downcase != 'true'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        