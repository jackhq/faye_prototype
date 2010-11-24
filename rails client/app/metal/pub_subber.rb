require "thread"

class PubSubber
  Thread.new {
    EventMachine::run do
      puts "IN THE LOOP!!!!"
      client = Faye::Client.new('http://localhost:9292')
  
      client.subscribe('/process_complete') do |message|
        request = Request.find(message['message']['id'])
        request.confirmation_number = message['message']['confirmation_number']
        request.received_date = Time.now
        request.save
      end
    end
  }
end

