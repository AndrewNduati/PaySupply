class Invoice < ApplicationRecord
  belongs_to :supplier
  enum pay_status: [:unpaid, :paid]
end
