require 'spec_helper'

describe ItemsController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  
    it "responds to xhr with formatted json" do
      2.times{|n| Factory.create(:item) }
      xhr :get, :index, :format => :json
      json = ActiveSupport::JSON.decode(response.body)
      json['total'].should eq(2)
      json['item'].should_not be_nil
    end
    
    it "processes overridden as_json" do
      2.times{|n| Factory.create(:item) }
      xhr :get, :index, :format => :json
      json = ActiveSupport::JSON.decode(response.body)
      json['item'].each do |item|
        item['name'].should_not be_nil
        item['created_at'].should be_nil
        item['updated_at'].should be_nil
      end
    end
  end
  
  describe "GET 'edit'" do
    it "processes overridden as_json" do
      item = Factory.create(:item)
      xhr :get, :edit, :id => item.id, :format => :json
      json = ActiveSupport::JSON.decode(response.body)
      json['data'].should_not be_nil
      json['data']['id'].should eq(item.id)
      json['data']['name'].should eq(item.name)
      json['data']['created_at'].should be_nil
      json['data']['updated_at'].should be_nil
    end
  end
end