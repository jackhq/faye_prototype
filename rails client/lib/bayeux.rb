# Using Faye from a Rails app
# ---------------------------

# http://faye.jcoglan.com

# Drop this in lib/bayeux.rb, so you don't have to deal with creating
# clients and managing EventMachine in your controllers. In your action
# methods, just use `Bayeux.publish('/foo', 'hello' => 'world')` to
# send messages to browsers and other processes.

# Because Faye is asynchronous, you'll find that your Rails actions
# may complete before the messages have been delivered to clients.

require 'forwardable'
require 'eventmachine'
require 'faye'

module Bayeux
  HOST = 'http://localhost:9292/'

  class << self
    extend Forwardable
    def_delegators :client, :publish, :subscribe

    def client
      ensure_em_running!
      @client ||= Faye::Client.new(HOST)
    end

    def ensure_em_running!
      Thread.new { EM.run } unless EM.reactor_running?
      while not EM.reactor_running?
      end
    end
  end
end

