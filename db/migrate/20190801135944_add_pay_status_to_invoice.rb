class AddPayStatusToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :pay_status, :integer, default: 0
  end
end
