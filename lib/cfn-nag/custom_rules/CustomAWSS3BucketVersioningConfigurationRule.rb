
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSS3BucketVersioningConfigurationRule < BaseRule
  def rule_text
    "[standards] AWS::S3::Bucket property [VersioningConfiguration] should exist, consider default values of [ {'Status': 'Enabled'} ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0249'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::S3::Bucket').select do |resource|
      resource.versioningconfiguration.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        