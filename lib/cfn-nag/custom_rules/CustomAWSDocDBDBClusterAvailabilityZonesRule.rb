
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSDocDBDBClusterAvailabilityZonesRule < BaseRule
  def rule_text
    "[zone-specific] AWS::DocDB::DBCluster property [AvailabilityZones] should exist"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0051'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::DocDB::DBCluster').select do |resource|
      resource.availabilityzones.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        