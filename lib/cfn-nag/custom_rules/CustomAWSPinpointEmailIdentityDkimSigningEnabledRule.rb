
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSPinpointEmailIdentityDkimSigningEnabledRule < BaseRule
  def rule_text
    "[standards] AWS::PinpointEmail::Identity property [DkimSigningEnabled] should exist, consider default values of [ True ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0187'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::PinpointEmail::Identity').select do |resource|
      resource.dkimsigningenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        