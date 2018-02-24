
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSRedshiftCluster_KmsKeyId < BaseRule
  def rule_text
    'AWS::Redshift::Cluster property [KmsKeyId] should exist and be {"Ref": "KmsKeyId"}'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-97'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Redshift::Cluster').select do |resource|
      resource.kmskeyid.nil? || resource.kmskeyid.to_s.downcase != '{"ref": "kmskeyid"}'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        