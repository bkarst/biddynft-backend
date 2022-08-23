class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :latest_ip, type: String
  field :voting_key, type: String
  field :crypto_address, type: String
  index({ email: 1 }, { unique: true, name: "email_index" })
  # field :duration, type: Integer
  
  def to_hash
    {
      email: email,
      voting_key: voting_key
    }
  end

end
