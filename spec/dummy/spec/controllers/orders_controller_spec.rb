require 'spec_helper'

describe OrdersController do
  
  context "ActiveRecord Relation" do

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end
    
      it "responds to xhr with formatted json" do
        Factory.create(:order)
        xhr :get, :index, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(1)
        json['order'].should_not be_nil
      end
      
      it "responds with correct root with no records" do
        xhr :get, :index, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(0)
        json['order'].should_not be_nil
      end
      
    end
  
    describe "GET 'change_root'" do
      it "responds to xhr with user passed root" do
        Factory.create(:order)
        xhr :get, :change_root, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(1)
        json['order'].should be_nil # root should be changed
        json['custom_root'].should_not be_nil # to user passed root
      end
    end
  
    describe "GET 'change_total'" do
      it "responds to xhr with user passed total" do
        Factory.create(:order)
        xhr :get, :change_total, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(34)
      end
    end
  
    describe "GET 'with_method'" do
      it "responds to xhr with user passed total, root, and method" do
        Factory.create(:order)
        xhr :get, :with_method, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(34)
        json['order'].should be_nil # root should be changed
        json['custom_root'].should_not be_nil # to user passed root
        json['custom_root'].each do |order|
          order['custom'].should_not be_nil
        end  
      end
    end
  
    describe "GET 'only_and_method'" do
      it "responds to xhr with user passed total, root, and method" do
        Factory.create(:order)
        xhr :get, :only_and_method, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(34)
        json['order'].should be_nil # root should be changed
        json['custom_root'].should_not be_nil # to user passed root
        json['custom_root'].each do |order|
          order['custom'].should_not be_nil
          order['id'].should be_nil
        end  
      end
    end
  
    describe "GET 'except_and_method'" do
      it "responds to xhr with user passed total, root, and method" do
        Factory.create(:order)
        xhr :get, :except_and_method, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(34)
        json['order'].should be_nil # root should be changed
        json['custom_root'].should_not be_nil # to user passed root
        json['custom_root'].each do |order|
          order['custom'].should_not be_nil
          order['created_at'].should be_nil
          order['updated_at'].should be_nil
        end  
      end
    end
  end
  
  context "ActiveRecord Relation with Nested Resource" do
    describe "GET 'index_with_nested_resource'" do
      it "responds to xhr with nested resource" do
        order = Factory.create(:order_with_items)
        xhr :get, :index_with_nested_resource, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should eq(1)
        json['order'].should_not be_nil
        json_order = json['order'].first
        json_order['name'].should_not be_nil
        json_order['items'].should be_a(Array)
        json_order['items'].size.should eq(order.items.count)
        json_order['items'].first['name'].should_not be_nil
      end
    end
  end
  
  #UNCOMMENT config/application.rb -> require "will_paginate" to test
  context "Pagination with will_paginate" do
      describe "GET 'index_will_paginate'" do
        it "responds with total_entries" do
          50.times{ |n| Factory.create(:order) }
          50.times{ |n| Factory.create(:order, :name => "Outlier #{n}") }
          xhr :get, :index_will_paginate, :format => :json
          json = ActiveSupport::JSON.decode(response.body)
          json['total'].should eq(50)
          json['order'].should_not be_nil
          json_order = json['order'].size.should eq(25)
        end
      end
    end
  
  #UNCOMMENT config/application.rb -> require "kaminari" to test
  # context "Pagination with kaminai" do
  #     describe "GET 'index_kaminari_pagination'" do
  #       it "responds with total_count" do
  #         50.times{ |n| Factory.create(:order) }
  #         50.times{ |n| Factory.create(:order, :name => "Outlier #{n}") }
  #         xhr :get, :index_kaminari_pagination, :format => :json
  #         json = ActiveSupport::JSON.decode(response.body)
  #         json['total'].should eq(50)
  #         json['order'].should_not be_nil
  #         json_order = json['order'].size.should eq(25)
  #       end
  #     end
  #   end
  
  context "Single Resource" do
  
    describe "GET 'edit'" do
      it "responds to xhr with formatted json" do
        order = Factory.create(:order)
        xhr :get, :edit, :id => order.id, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should be_nil
        json['data'].should_not be_nil
        json['data']['id'].should eq(order.id)
      end
    end
  
    describe "GET 'edit_change_root'" do
      it "responds to xhr with formatted json" do
        order = Factory.create(:order)
        xhr :get, :edit_change_root, :id => order.id, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should be_nil
        json['data'].should be_nil
        json['custom_root'].should_not be_nil
        json['custom_root']['id'].should eq(order.id)
      end
    end
  
    describe "GET 'edit_with_method'" do
      it "responds to xhr with formatted json" do
        order = Factory.create(:order)
        xhr :get, :edit_with_method, :id => order.id, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should be_nil
        json['data'].should be_nil
        json['custom_root'].should_not be_nil
        json['custom_root']['id'].should eq(order.id)
        json['custom_root']['custom'].should_not be_nil
      end
    end
  
    describe "GET 'edit_only_and_method'" do
      it "responds to xhr with formatted json" do
        order = Factory.create(:order)
        xhr :get, :edit_only_and_method, :id => order.id, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should be_nil
        json['data'].should be_nil
        json['custom_root'].should_not be_nil
        json['custom_root']['id'].should eq(order.id)
        json['custom_root']['custom'].should_not be_nil
        json['custom_root']['created_at'].should be_nil
        json['custom_root']['updated_at'].should be_nil
      end
    end
  
    describe "GET 'edit_except_and_method'" do
      it "responds to xhr with formatted json" do
        order = Factory.create(:order)
        xhr :get, :edit_except_and_method, :id => order.id, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['total'].should be_nil
        json['data'].should be_nil
        json['custom_root'].should_not be_nil
        json['custom_root']['id'].should eq(order.id)
        json['custom_root']['custom'].should_not be_nil
        json['custom_root']['created_at'].should be_nil
        json['custom_root']['updated_at'].should be_nil
      end
    end
    
    describe "GET 'edit_with_nested_resource'" do
      it "responds to xhr with nested resource" do
        order = Factory.create(:order_with_items)
        xhr :get, :edit_with_nested_resource, :id => order.id, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json['data'].should_not be_nil
        json_order = json['data']
        json_order['items'].should be_a(Array)
        json_order['items'].size.should eq(order.items.count)
        json_order['items'].first['name'].should_not be_nil
      end
    end
  end
end
