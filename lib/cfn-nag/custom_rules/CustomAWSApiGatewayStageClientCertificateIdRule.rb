
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSApiGatewayStageClientCertificateIdRule < BaseRule
  def rule_text
    "[PKI Encryption] AWS::ApiGateway::Stage property [ClientCertificateId] should exist, consider default values of [ {'Ref': 'TODO'} ]  [WA-sec_network_protection_layered]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0018'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::ApiGateway::Stage').select do |resource|
      resource.clientcertificateid.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        