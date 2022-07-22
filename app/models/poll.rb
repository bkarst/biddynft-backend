class Poll
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :chain, type: String
  field :duration, type: Integer
end
