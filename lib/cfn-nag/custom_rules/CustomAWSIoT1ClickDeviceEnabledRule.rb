
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSIoT1ClickDeviceEnabledRule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::IoT1Click::Device property [Enabled] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0234'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::IoT1Click::Device').select do |resource|
      resource.enabled.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        