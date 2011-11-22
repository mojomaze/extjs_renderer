class OrdersController < ApplicationController
  respond_to :html, :json
  def index
    @orders = Order.order('name')
    respond_with @orders do |format|
      format.json { render :extjs => @orders }
    end
  end
  
  def index_with_nested_resource
    @orders = Order.order('name')
    respond_with @orders do |format|
      format.json { render :extjs => @orders, :include => :items }
    end
  end
  
  def change_root
    @orders = Order.order('name')
    respond_with @orders do |format|
      format.json { render :extjs => @orders, :root => 'custom_root' }
    end
  end
  
  def change_total
    @orders = Order.order('name')
    respond_with @orders do |format|
      format.json { render :extjs => @orders, :total => 34 }
    end
  end
  
  def with_method
    @orders = Order.order('name')
    respond_with @orders do |format|
      format.json { render :extjs => @orders, :root => 'custom_root', :total => 34, 
                          :methods => [:custom] }
    end
  end
  
  def only_and_method
    @orders = Order.order('name')
    respond_with @orders do |format|
      format.json { render :extjs => @orders, :root => 'custom_root', :total => 34, 
                        :only => :name, :methods => :custom }
    end
  end
  
  def except_and_method
    @orders = Order.order('name')
    respond_with @orders do |format|
      format.json { render :extjs => @orders, :root => 'custom_root', :total => 34, 
                        :except => [:created_at, :updated_at], :methods => :custom }
    end
  end
  
  # pagination
  def index_will_paginate
    @orders = Order.where("name LIKE ?", '%order%').paginate(:page => 1, :per_page => 25)
    respond_with @orders do |format|
      format.json { render :extjs => @orders }
    end
  end
  
  def index_kaminari_pagination
    @orders = Order.where("name LIKE ?", '%order%').page(1)
    respond_with @orders do |format|
      format.json { render :extjs => @orders }
    end
  end
  
  def edit
    @order = Order.find(params[:id])
    respond_with @order do |format|
      format.json { render :extjs => @order }
    end
  end
  
  def edit_change_root
    @order = Order.find(params[:id])
    respond_with @order do |format|
      format.json { render :extjs => @order, :root => 'custom_root' }
    end
  end
  
  def edit_with_method
    @order = Order.find(params[:id])
    respond_with @order do |format|
      format.json { render :extjs => @order, :root => 'custom_root',
                        :methods => :custom }
    end
  end
  
  def edit_only_and_method
    @order = Order.find(params[:id])
    respond_with @order do |format|
      format.json { render :extjs => @order, :root => 'custom_root',
                        :methods => :custom, :only => [:id, :name] }
    end
  end
  
  def edit_except_and_method
    @order = Order.find(params[:id])
    respond_with @order do |format|
      format.json { render :extjs => @order, :root => 'custom_root',
                        :methods => :custom, :except => [:created_at, :updated_at] }
    end
  end
  
  def edit_with_nested_resource
    @order = Order.find(params[:id])
    respond_with @order do |format|
      format.json { render :extjs => @order, :include => :items }
    end
  end

end
