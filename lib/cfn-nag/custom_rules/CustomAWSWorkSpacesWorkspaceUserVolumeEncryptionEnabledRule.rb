
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSWorkSpacesWorkspaceUserVolumeEncryptionEnabledRule < BaseRule
  def rule_text
    "[encrypted] AWS::WorkSpaces::Workspace property [UserVolumeEncryptionEnabled] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0122'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::WorkSpaces::Workspace').select do |resource|
      resource.uservolumeencryptionenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        