json.extract! poll_response, :id, :created_at, :updated_at
json.url poll_response_url(poll_response, format: :json)
