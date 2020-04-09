describe ActionHook do

  it 'returns the default configuration' do
    expect(ActionHook.configuration).to eql(ActionHook::DEFAULT_CONFIGURATION)
  end

  it 'sets a custom configuration' do
    custom_config = ActionHook::Core::Configuration.new

    ActionHook.configuration = custom_config

    expect(ActionHook.configuration).to eql(custom_config)
  end

end
