# Why?

A drop-in library for sending webhooks. You specify the content and
destination, Actionhooks takes care of securely delivering it following industry
best-practices.


# Requirements:

- [x] **Core** Send webhooks
- [x] **Configuration** Timeout
- [ ] **Security** Blocked IP ranges
- [ ] **Security** Hashing with secure key
- [ ] **More** Logging
- [ ] **More** Instrumentation
- [ ] **HTTP Adapters** Allow the use of different REST clients
- [ ] **Performance** HTTP keep-alive, gzip / compress
- [ ] **Scale** Trigger using AWS Lambda, GCP, Azure functions, Docker


## Send Webhooks

```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHttpSender.send(request)
```

## Configuration

```ruby
ActionHook.configuration.open_timeout = 3 # default is 5 seconds
ActionHook.configuration.read_timeout = 10 # default is 10 seconds
```