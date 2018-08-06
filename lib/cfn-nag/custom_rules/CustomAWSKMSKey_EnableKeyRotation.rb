
require 'cfn-nag/violation'
require_relative 'base'
#require 'cfn-nag/custom_rules/base'

class AWSKMSKey_EnableKeyRotation < BaseRule
  def rule_text
    'AWS::KMS::Key property [EnableKeyRotation] should exist '
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'encrypted-78'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::KMS::Key').select do |resource|
      resource.enablekeyrotation.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        