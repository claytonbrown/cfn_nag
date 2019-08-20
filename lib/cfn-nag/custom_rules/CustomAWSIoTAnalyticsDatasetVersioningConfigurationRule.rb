
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSIoTAnalyticsDatasetVersioningConfigurationRule < BaseRule
  def rule_text
    "[standards] AWS::IoTAnalytics::Dataset property [VersioningConfiguration] should exist, consider default values of [ {'Status': 'Enabled'} ]  []"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0158'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::IoTAnalytics::Dataset').select do |resource|
      resource.versioningconfiguration.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        