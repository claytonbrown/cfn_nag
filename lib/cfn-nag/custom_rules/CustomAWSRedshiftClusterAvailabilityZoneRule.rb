
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRedshiftClusterAvailabilityZoneRule < BaseRule
  def rule_text
    "[zone-specific] AWS::Redshift::Cluster property [AvailabilityZone] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0229'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Redshift::Cluster').select do |resource|
      resource.availabilityzone.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        