class Supplier < ApplicationRecord
  has_many :invoices

  validates :name, presence: true

  validates :bank_name,
            presence: true

  validates :account_number, presence: true,
            length: { minimum: 10,
                      maximum: 10,
                      message: 'Please insert the NUBAN account number.' }

end
