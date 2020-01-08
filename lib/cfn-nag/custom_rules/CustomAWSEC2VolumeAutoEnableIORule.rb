
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2VolumeAutoEnableIORule < BaseRule
  def rule_text
    "[Default ON for enable properties] AWS::EC2::Volume property [AutoEnableIO] should exist, consider default values of [ true ]  [TODO]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0166'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::Volume').select do |resource|
      resource.autoenableio.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        