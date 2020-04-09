require "actionhook/version"
require "actionhook/core/configuration"
require "actionhook/core/request"
require "actionhook/core/json_request"
require "actionhook/core/net_http_sender"

module ActionHook
  class Error < StandardError; end
  DEFAULT_CONFIGURATION = ActionHook::Core::Configuration.new

  def self.configuration=(configuration)
    @configuration = configuration
  end

  def self.configuration
    @configuration || DEFAULT_CONFIGURATION
  end
end
