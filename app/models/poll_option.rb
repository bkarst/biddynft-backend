class PollOption
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :poll
  field :description, type: String
  field :poll_order, type: Integer

end
