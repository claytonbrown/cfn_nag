
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRedshiftClusterSubnetGroupTagsRule < BaseRule
  def rule_text
    "[taggable] AWS::Redshift::ClusterSubnetGroup property [Tags] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0115'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Redshift::ClusterSubnetGroup').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        