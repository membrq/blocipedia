class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy

  before_save { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
