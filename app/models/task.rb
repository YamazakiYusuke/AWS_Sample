class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  scope :title_scope, -> (params_sarch_title) { where('title like?', "%#{params_sarch_title}%") }
  scope :status_scope, -> (params_sarch_status) { where(status:params_sarch_status) }

  enum priority: { 低: 0, 中: 1, 高: 2 }
end
