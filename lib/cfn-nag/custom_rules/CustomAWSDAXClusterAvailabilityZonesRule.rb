
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSDAXClusterAvailabilityZonesRule < BaseRule
  def rule_text
    "[zone-specific] AWS::DAX::Cluster property [AvailabilityZones] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0078'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::DAX::Cluster').select do |resource|
      resource.availabilityzones.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        