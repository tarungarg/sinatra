class Order < ActiveRecord::Base
  validates_presence_of :order_no
  validates_presence_of :date
  validates :total, numericality: true
  validates_presence_of :total
  belongs_to :user, foreign_key: "customer_id"
  has_many :order_lines
end