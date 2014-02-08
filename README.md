# Fluent::Plugin::ResqueStat, a plugin for [Fluentd](http://fluentd.org) [![Build Status](https://travis-ci.org/SpringMT/fluent-plugin-resque_stat.png)](https://travis-ci.org/SpringMT/fluent-plugin-resque_stat)

Fluent input plugin for Resque info

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-resque_stat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-resque_stat

## Configuration

```
<source>
  type resque_stat
  tag resque
  host 127.0.0.1
  port 6379
  run_interval 1s
 </source>
```
## Output Format

Sample  
{:pending=>0, :processed=>46, :queues=>1, :workers=>0, :working=>0, :failed=>0, :servers=>["redis://:6379/0"], :environment=>"development"}  

Record  

```json
{
  "pending": 0,
  "processed": 46,
  "queues": 1,
  "workers": 0,
  "working": 0,
  "failed": 0,
  "servers": "[\"redis://:6379/0\"]",
  "environment": "development"
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

