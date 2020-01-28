
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSWorkSpacesWorkspaceRootVolumeEncryptionEnabledRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::WorkSpaces::Workspace property [RootVolumeEncryptionEnabled] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0420'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::WorkSpaces::Workspace').select do |resource|
      resource.rootvolumeencryptionenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        