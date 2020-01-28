
require 'cfn-nag/violation'
require_relative 'base'

class CustomAWSOpsWorksCMServerCustomCertificateRule < BaseRule
  def rule_text
    "[PKI Encryption] AWS::OpsWorksCM::Server property [CustomCertificate] should exist, consider default values of [ {'Ref': 'TODO'} ]  [WA-sec_network_protection_layered]"
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'C-0293'
  end

  def audit_impl(cfn_model)
    violating_resources = cfn_model.resources_by_type('AWS::OpsWorksCM::Server').select do |resource|
      resource.customcertificate.nil?
    end

    violating_resources.map { |violating_resource| violating_resource.logical_resource_id }
  end
end
        