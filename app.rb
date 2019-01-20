require 'sinatra'
require 'sinatra/base'
require 'json'
require 'thin'

# Alpine Sinatra application class
class App < Sinatra::Base
  configure do
    enable :logging
  end

  get '/' do
    'Hello from Alpine Sinatra in Docker!'
  end

  # Show environment info
  get '/env' do
    if params[:json] === 'yes'
      content_type :json
      ENV.to_h.to_json
    else
      '<p>Environment (as <a href="/env?json=yes">JSON</a>):</p><ul>' +
        ENV.each.map {|k, v| "<li><b>#{k}:</b> #{v}</li>"}.join + '</ul>'
    end
  end

  # Show disk info
  get '/disk' do
    "<strong>Disk:</strong><br/><pre>#{`df -h`}</pre>"
  end

  # Show memory info
  get '/memory' do
    "<strong>Memory:</strong><br/><pre>#{`free -m`}</pre>"
  end

  # Exit 'correctly'
  get '/exit' do
    Process.kill('TERM', Process.pid)
  end

  # Just terminate
  get '/fail' do
    Process.kill('KILL', Process.pid)
  end

  # Artificial delay...
  get '/sleep' do
    # Just sleep...
    seconds = params[:seconds].to_f || 1.0
    sleep seconds
    "Delayed #{seconds} sec.<br/><strong>Tip:</strong> use `/sleep?seconds=3`"
  end

  # Post form
  get '/form' do
    '<form action="/form" method="post">' \
    '<input type="text" name="message"><br />' \
    '<input type="checkbox" name="log">Show in log<br />' \
    '<input type="submit"></form>'
  end

  # Post
  post '/form' do
    logger.info "#{params[:message]}" if params[:log]
    params[:message]
  end
end
