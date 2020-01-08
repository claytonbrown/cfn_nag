
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSPinpointEmailIdentityFeedbackForwardingEnabledRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::PinpointEmail::Identity property [FeedbackForwardingEnabled] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0315'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::PinpointEmail::Identity').select do |resource|
      resource.feedbackforwardingenabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        