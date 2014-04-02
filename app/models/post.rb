class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts

  scope :by_user, -> u { where(user_id: u) }

  def owner?
    user_id == current_user
  end
end
