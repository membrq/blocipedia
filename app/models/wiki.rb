class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user){user ? all : where(public: true)}
end
