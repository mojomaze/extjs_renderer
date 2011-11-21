class ItemsController < ApplicationController
  respond_to :html, :json
  
  def index
    @items = Item.order('name')
    respond_with @items do |format|
      format.json { render :extjs => @items }
    end
  end
  
  def edit
    @item = Item.find(params[:id])
    respond_with @item do |format|
      format.json { render :extjs => @item }
    end
  end
end