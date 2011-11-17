class Order < ActiveRecord::Base
  has_many :items
  
  attr_accessor :custom
  
  # custom attribute
  def custom
     "Populated Custom Value"
  end
end
