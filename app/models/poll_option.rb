class PollOption
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :poll
  field :description, type: String
  field :poll_order, type: Integer

  def to_hash
    {
      id: id.to_s,
      description: description,
      poll_order: poll_order
  }
  end

end
