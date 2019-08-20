
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSEC2VolumeAvailabilityZoneRule < BaseRule
  def rule_text
    "[zone-specific] AWS::EC2::Volume property [AvailabilityZone] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0111'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::EC2::Volume').select do |resource|
      resource.availabilityzone.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        