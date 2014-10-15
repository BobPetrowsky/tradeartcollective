class AddColumnPayerEmailToSales < ActiveRecord::Migration
  def change
    add_column :sales, :payer_email, :string, null: false
  end
end
