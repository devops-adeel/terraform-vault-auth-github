#!/usr/bin/env ruby
#
# -*- mode: ruby -*-
# vi: set ft=ruby :
#

content   = inspec.profile.file('terraform.json')
params    = JSON.parse(content)
url       = params['url']['value']
namespace = params['namespace']['value']
org       = params['org']['value']
login     = 'auth/github/login'


url_login = "#{url}/v1/#{namespace}#{login}"
uri = URI(url_login)
response = Net::HTTP.post_form(uri, :token => input('github_token'))
client = JSON.parse(response.body)
client_token = client['auth']['client_token']

github_token = JSON.generate({:token => input('github_token')})
token_lookup = JSON.generate({:token => "#{client_token}"})

title "Vault Integration Test"

control "vlt-1.0" do
  impact 0.7
  title 'Login to Vault using github auth'
  desc 'Login to Vault using github auth'

  describe http(
    "#{url}/v1/#{namespace}#{login}",
    method: 'POST',
    data: github_token.to_s
  ) do

    its('status') { should eq 200 }
  end
end

control 'vlt-2.0' do
  impact 0.7
  title 'Ensure token has correct policies'
  desc 'Ensure token has correct policies'

  describe json(
    content: http(
    "#{url}/v1/#{namespace}#{login}",
    method: 'POST',
    data: github_token.to_s
    ).body
  ) do

    its(['auth', 'policies']) { should include 'default' }
    its(['auth', 'policies']) { should_not include 'admin' }
    its(['auth', 'metadata', 'username']) { should eq 'devops-adeel' }
    its(['auth', 'metadata', 'org']) { should eq org }
  end
end

control "vlt-3.0" do
  impact 0.7
  title "Test health"
  desc "Test health"

  describe http(
    "#{url}/v1/sys/health?perfstandbyok=true",
    method: 'GET'
  ) do
    its('status') { should eq 200 }
  end
end

control 'vlt-4.0' do
  impact 0.7
  title 'Ensure token has correct policies'
  desc 'Ensure token has correct policies'

  describe json(
    content: http(
      "#{url}/v1/#{namespace}auth/token/lookup-self",
      method: 'GET',
      headers: {'X-Vault-Token' => "#{client_token}"}
    ).body
  ) do

    its(['data', 'identity_policies']) { should include 'default' }
    its(['data', 'identity_policies']) { should_not include 'admin' }
  end
end
