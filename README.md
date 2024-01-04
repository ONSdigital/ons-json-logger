# ONS JSON Logger RubyGem
A utility class for generating structured JSON log entries with optional additional fields suitable for web applications. Note that this gem targets Ruby 3.1 and above.

## Installation
```
gem install ons-json-logger
```

## Examples

```ruby
require 'logger'
require 'ons-json-logger'
require 'sinatra'

LOGGER      = Logger.new($stdout)
JSON_LOGGER = JSONLogger.new(application: 'amazing-webapp', environment: 'production')

get '/signout' do
  LOGGER.info(JSON_LOGGER.log(level: 'INFO',
                              message: 'User signed out',
                              module_name: 'app',
                              user: { id: @user_login_id, ip_address: @client_ip },
                              http: { method: 'GET', path: '/signout', status: 200, user_agent: request.user_agent }))
end
```

## Testing
```
rake test
```

## Licence
This library is licensed under the MIT licence. Full licence text is available in [LICENCE](LICENCE).

## Copyright
Copyright (C) 2024 Crown Copyright (Office for National Statistics)
