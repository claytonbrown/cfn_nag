
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSRedshiftClusterSecurityGroupTagsRule < BaseRule
  def rule_text
    "[taggable] AWS::Redshift::ClusterSecurityGroup property [Tags] should exist "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0114'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Redshift::ClusterSecurityGroup').select do |resource|
      resource.tags.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        