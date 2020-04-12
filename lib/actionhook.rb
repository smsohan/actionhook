require 'logger'
require "ipaddr"
require "actionhook/version"
require "actionhook/core/configuration"
require "actionhook/security/authentication"
require "actionhook/core/request"
require "actionhook/core/json_request"
require "actionhook/core/net_http_sender"

module ActionHook
  class Error < StandardError; end

  DEFAULT_CONFIGURATION = ActionHook::Core::Configuration.new

  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.configuration=(configuration)
    @configuration = configuration
  end

  def self.configuration
    @configuration || DEFAULT_CONFIGURATION
  end
end
