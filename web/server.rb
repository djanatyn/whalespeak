#!/usr/bin/env ruby
require 'whalespeak'
require 'sinatra'
require 'json'
require 'json-schema'

set :port, 1234
set :environment, :production

# schema for translating
$schema = {
  '$schema' => 'http://json-schema.org/draft-04/schema#',
  'type' => 'object',
  'properties' => {
    'text' => {
      'description' => 'text to be translated',
      'type' => 'string',
    },
  },
  'required' => ['text'],
}

get '/api/schema' do
  return JSON.dump $schema
end
    
post '/api/translate/to' do
  request.body.rewind; json = request.body.read

  begin
    # validate and parse JSON
    JSON::Validator.validate!($schema, json, :strict => true)
    data = JSON.parse json
    
    converted_text = Whalespeak::CommonWhale.to_whalespeak data['text']
    response = JSON.dump({ translation: converted_text})
  rescue => e
    response = JSON.dump({ exception: e.class, error: e.message })
  end

  return response + "\n"
end

post '/api/translate/from' do
  request.body.rewind; json = request.body.read

  begin
    # validate and parse JSON
    JSON::Validator.validate!($schema, json, :strict => true)
    data = JSON.parse json

    # convert and generate response
    converted_text = Whalespeak::CommonWhale.from_whalespeak data['text']
    response = JSON.dump({ translation: converted_text })
  rescue => e
    response = JSON.dump({ exception: e.class, error: e.message })
  end

  return response + "\n"
end

not_found do
  status 404

  response = JSON.dump({ error: 'invalid api url'})
  return response + "\n"
end
