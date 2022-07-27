class PollOption
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :poll
  field :description, type: String
  field :thumbnail_url, type: String
  field :poll_order, type: Integer
  field :active, type: Integer, default: 1

  def to_hash
    {
      id: id.to_s,
      description: description,
      thumbnail_url: thumbnail_url,
      poll_order: poll_order
  }
  end

end
