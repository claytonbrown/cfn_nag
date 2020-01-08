
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSApiGatewayV2StageClientCertificateIdRule < BaseRule
  def rule_text
    "[PKI Encryption] AWS::ApiGatewayV2::Stage property [ClientCertificateId] should exist, consider default values of [ {'Ref': 'TODO'} ]  [WA-sec_network_protection_layered]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0026'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ApiGatewayV2::Stage').select do |resource|
      resource.clientcertificateid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        