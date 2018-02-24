
require 'cfn-nag/violation'
#require 'cfn-nag/custom_rules/base'
require_relative 'base'

class AWSKMSKey_EnableKeyRotation < BaseRule
  def rule_text
    ''
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'Custom-70'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::KMS::Key').select do |resource|
      resource.enablekeyrotation.nil? || resource.enablekeyrotation.to_s.downcase != 'true'
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        