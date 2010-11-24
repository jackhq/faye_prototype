require 'faye'

faye_server = Faye::RackAdapter.new(:mount => '/', :timeout => 30)

run faye_server
