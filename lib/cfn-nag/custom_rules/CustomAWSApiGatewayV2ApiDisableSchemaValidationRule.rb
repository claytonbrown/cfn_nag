
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSApiGatewayV2ApiDisableSchemaValidationRule < BaseRule
  def rule_text
    "[standards] AWS::ApiGatewayV2::Api property [DisableSchemaValidation] should exist, consider default values of [ False ] "
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0006'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ApiGatewayV2::Api').select do |resource|
      resource.disableschemavalidation.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        