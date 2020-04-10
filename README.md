# Why?

A drop-in library for sending webhooks. You specify the content and
destination, ActionHook takes care of securely delivering it following industry
best-practices.


## Build Status

![Build](https://github.com/smsohan/actionhook/workflows/Ruby/badge.svg)

# Features:

- [x] **Core** Send webhooks
- [x] **Configuration** Timeout
- [x] **Security** Auth Token
- [x] **Security** Blocked IP ranges
- [x] **Security** Hashing with secure key
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


All configurations are optional, only use these if you want to override the defaults
```ruby
ActionHook.configuration.open_timeout = 3 # default is 5 seconds
ActionHook.configuration.read_timeout = 10 # default is 10 seconds
ActionHook.configuration.hash_header_name = 'CUSTOM-HASH-HEADER' # default is SHA256-FINGERPRINT
```

## Hashing With a Secure Key
```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  secret: '<Your Secret For This Hook>', # Remember to provide your secret
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHttpSender.send(request)
# Will automatically append header named CUSTOM-HASH-HEADER with the SHA256 fingerprint of the request body.
```

## IP Blocking

ActionHook automatically blocks sending webhooks to local and private IP space as described by RFC 1918.
You can configure custom IP ranges that should also be blocked or disable the block on private IPs.

```ruby
ActionHook.configuration.allow_private_ips = true # This is dangerous for production. Default is false.
ActionHook.configuration.blocked_ip_ranges = ['p.q.r.s/24'] # You can configure an array of custom ranges
```

Or, you can provide a configuration at send time, as follows:

```ruby
ActionHook::Core::NetHTTPSender.send(request,
  ActionHook::Core::Configuration.new(allow_private_ips: true, # This is dangerous in production
    blocked_ip_ranges: ['p.q.r.s/24']
  )
)
```

When a request is blocked due to private IP, the `send` raises `ActionHook::Security::IPBlocking::PrivateIPError`.
When a request is blocked due to the blocked_ip_ranges, `send` raises `ActionHook::Security::IPBlocking::BlockedRequestError`.
In both cases, the error message includes necessary context for debugging / logging.
