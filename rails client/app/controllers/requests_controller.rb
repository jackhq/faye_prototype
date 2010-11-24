require "bayeux"

class RequestsController < ApplicationController
  respond_to :html, :json
  
  def index
    @requests = Request.all
    respond_with @requests
  end
  
  def new
    @request = Request.new
    respond_with @request
  end
  
  def create
    puts "Request"
    @request = Request.new(params[:request].merge(:sent_date => DateTime.now))
    @request.save
    Bayeux.publish('/process_me', 'request' => {'description' => @request.description, 'id' => @request.id})
    respond_with @request, :location => requests_path
  end

  def publish
    Bayeux.publish('/process_me', 'text' => 'test')
  end
  
end
