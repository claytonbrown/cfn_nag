
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSNeptuneDBClusterAvailabilityZonesRule < BaseRule
  def rule_text
    "[zone-specific] AWS::Neptune::DBCluster property [AvailabilityZones] should exist"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0163'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Neptune::DBCluster').select do |resource|
      resource.availabilityzones.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        