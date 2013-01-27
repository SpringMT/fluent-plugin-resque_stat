#!/usr/bin/env ruby
# encoding: UTF-8

require 'fluent/test'

require File.dirname(__FILE__) + '/spec_helper'

DEFAULT_CONFIG = %[
  tag test
  host 127.0.0.1
  port 6379
  run_interval 1s
]

describe Fluent::ResqueStatInput do
  before { Fluent::Test.setup }
  context 'test_emit' do
    it do
      d = Fluent::Test::InputTestDriver.new(Fluent::ResqueStatInput).configure(DEFAULT_CONFIG)
      d.run do
        sleep 2
      end
      emits = d.emits
      emits.length.should > 0
      emits[0][0].should eql('test')
      emits[0][2].keys.should eql(['pending', 'processed', 'queues', 'workers', 'working', 'failed', 'servers', 'environment'])
    end
  end

end



