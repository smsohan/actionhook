require "actionhook/version"

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
