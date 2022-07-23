class PollOption
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :poll
  field :description, type: String
  field :poll_order, type: Integer

  def to_hash
    {
      description: self.description,
      poll_order: self.poll_order
  }
  end

end
