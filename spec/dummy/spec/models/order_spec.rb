require 'spec_helper'

describe Order do
  
  # UNCOMMENT config/application.rb -> require "will_paginate" to test
  it "paginates with will_paginate" do
      50.times{ |n| Factory.create(:order) }
      50.times{ |n| Factory.create(:order, :name => "Outlier #{n}") }
      @orders = Order.where("name LIKE ?", '%order%').paginate(:page => 1, :per_page => 40)
      @orders.count.should eq(50)
      @orders.size.should eq(40)
      Order.count.should eq(100)
    end
  
  # UNCOMMENT config/application.rb -> require "kaminari" to test
  # it "paginates with kaminari" do
  #     50.times{ |n| Factory.create(:order) }
  #     50.times{ |n| Factory.create(:order, :name => "Outlier #{n}") }
  #     @orders = Order.where("name LIKE ?", '%order%').page(1).per(40)
  #     @orders.size.should eq(40)
  #     @orders.total_count.should eq(50)
  #     Order.count.should eq(100)
  #   end
end