#!/usr/bin/env ruby
require 'whalespeak'
require 'sinatra'
require 'json'
require 'json-schema'

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
    
post '/translate/to' do
  # get request as JSON
  request.body.rewind; data = JSON.parse request.body.read

  begin
    JSON::Validator.validate!($schema, data, :strict => true)
  rescue JSON::Schema::ValidationError
    response = { error: $!.message }

    return JSON.dump(response) + "\n"
  end

  response = { translation: Whalespeak::CommonWhale.to_whalespeak(data['text']) }
  return JSON.dump(response) + "\n"
end

post '/translate/from' do
  # get request as JSON
  request.body.rewind; data = JSON.parse request.body.read

  begin
    JSON::Validator.validate!($schema, data, :strict => true)
  rescue JSON::Schema::ValidationError
    response = { error: $!.message }

    return JSON.dump(response) + "\n"
  end

  response = { translation: Whalespeak::CommonWhale.from_whalespeak(data['text']) }
  return JSON.dump(response) + "\n"
end
