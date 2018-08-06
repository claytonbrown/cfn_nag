
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSWorkSpacesWorkspace_UserVolumeEncryptionEnabled < BaseRule
  def rule_text
    'AWS::WorkSpaces::Workspace property [UserVolumeEncryptionEnabled] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'encrypted-122'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::WorkSpaces::Workspace').select do |resource|
      resource.uservolumeencryptionenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        