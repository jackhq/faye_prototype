require 'faye'
require 'sequel'
DB = Sequel.connect(:adapter => 'mysql' , :host => 'localhost', :database => 'windows_faye_daemon', :user => 'root', :password => '')

class Message < Sequel::Model
  set_allowed_columns :description, :external_id, :received_date
end

EM.run {
  client = Faye::Client.new('http://localhost:9292')
  client.subscribe('/process_me') do |message|
    attributes = message['request']
    subscriber = Message.create(:description => attributes['description'],
                                 :external_id => attributes['id'],
                                 :received_date => Time.now)
    client.publish('/process_complete', {'message' =>{'id' => subscriber.external_id, 'confirmation_number' => subscriber.id }})
  end
}

