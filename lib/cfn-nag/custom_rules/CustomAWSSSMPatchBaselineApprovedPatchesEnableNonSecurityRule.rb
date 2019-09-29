
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSSSMPatchBaselineApprovedPatchesEnableNonSecurityRule < BaseRule
  def rule_text
    "[standards] AWS::SSM::PatchBaseline property [ApprovedPatchesEnableNonSecurity] should exist, consider default values of [ False ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0271'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::SSM::PatchBaseline').select do |resource|
      resource.approvedpatchesenablenonsecurity.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        