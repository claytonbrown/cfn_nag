
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSKinesisStream_StreamEncryption < BaseRule
  def rule_text
    'AWS::Kinesis::Stream property [StreamEncryption] should exist and be set to 'KMS' with reference to KmsKeyID parameter'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-80'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::Kinesis::Stream').select do |resource|
      resource.streamencryption.nil? || resource.streamencryption.to_s.downcase != 'type:string:kms'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        