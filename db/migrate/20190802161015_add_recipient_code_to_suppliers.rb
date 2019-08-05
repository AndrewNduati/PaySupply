class AddRecipientCodeToSuppliers < ActiveRecord::Migration[5.2]
  def change
    add_column :suppliers, :recipient_code, :string
  end
end
