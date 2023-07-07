class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end  
    
  def index
    @items = Item.all
  end  
  
  def show
    @item = Item.find(params[:id])
  end 
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_items_path
  end  
  
  private
  
  def item_params
    params.require(:item).permit(:name, :description, :genre_id, :item_image, :price_without_tax, :is_active)
  end  
end