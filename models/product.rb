class Product < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :price
  validates :price, numericality: true
  validates_presence_of :description
  has_many :order_lines
end