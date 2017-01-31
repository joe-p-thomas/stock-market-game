class Stock < ApplicationRecord
  validates :shares, presence: true

  belongs_to(:user,
              foreign_key: :user_id,
              class_name: 'User')

  belongs_to(:company,
              foreign_key: :company_id,
              class_name: 'Company')
end