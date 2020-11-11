class User < ApplicationRecord
  before_destroy :ensure_there_is_an_owner

  has_many :tasks, dependent: :destroy
  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 8 }

  private
  def ensure_there_is_an_owner
    if self.admin && User.where(admin: :true).count <= 1
      throw(:abort)
    end
  end
end
