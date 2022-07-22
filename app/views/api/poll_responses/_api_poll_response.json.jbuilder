json.extract! api_poll_response, :id, :created_at, :updated_at
json.url api_poll_response_url(api_poll_response, format: :json)
