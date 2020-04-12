describe ActionHook do

  it 'returns the default configuration' do
    expect(ActionHook.configuration).to eql(ActionHook::DEFAULT_CONFIGURATION)
  end

  it 'sets a custom configuration' do
    custom_config = ActionHook::Core::Configuration.new

    ActionHook.configuration = custom_config

    expect(ActionHook.configuration).to eql(custom_config)
  end

  it 'has a logger' do
    expect(ActionHook.logger).not_to be_nil
  end

  it 'allows a custom logger to be set' do
    logger = Logger.new("/dev/null")
    ActionHook.logger = logger
    expect(ActionHook.logger).to eql logger
  end

end
