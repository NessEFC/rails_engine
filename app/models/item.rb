class Item < ApplicationRecord
  validates :name, :description, :unit_price, :created_at, :updated_at, :merchant, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    Item.joins(invoice_items: :transactions).merge(Transaction.successful).group("id").order("sum(invoice_items.unit_price * invoice_items.quantity) desc").limit(quantity)
  end
end
