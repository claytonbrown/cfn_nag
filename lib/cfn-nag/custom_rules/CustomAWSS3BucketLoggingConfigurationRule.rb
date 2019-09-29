
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSS3BucketLoggingConfigurationRule < BaseRule
  def rule_text
    "[logging] AWS::S3::Bucket property [LoggingConfiguration] should exist []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0260'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::S3::Bucket').select do |resource|
      resource.loggingconfiguration.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        