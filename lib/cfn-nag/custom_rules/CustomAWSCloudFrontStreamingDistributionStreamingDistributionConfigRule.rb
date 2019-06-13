
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSCloudFrontStreamingDistributionStreamingDistributionConfigRule < BaseRule
  def rule_text
    "[standards] AWS::CloudFront::StreamingDistribution property [StreamingDistributionConfig] should exist, consider default values of [ {'Logging': {'Bucket': {'Ref': 'LoggingDestination'}, 'Enabled': True, 'Prefix': {'Fn::Join': ['/', ['cloudfront', {'Ref': 'AWS::Region'}, {'Ref': 'AWS::StackName'}, '{{resource_name}}']]}}} ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0019'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::CloudFront::StreamingDistribution').select do |resource|
      resource.streamingdistributionconfig.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        