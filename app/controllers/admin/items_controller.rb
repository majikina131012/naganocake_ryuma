class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end  
    
  # def index
  #   @items = Item.all
  # end  
  
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.includes(:genre)
    end
    @items = all_items.page(params[:page])
    @all_items_count = all_items.count
  end
  
  def show
    @item = Item.find(params[:id])
  end 
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_items_path
  end  
  
  def edit
    @item = Item.find(params[:id])
  end  
  
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_items_path
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :description, :genre_id, :item_image, :price_without_tax, :is_active)
  end  
end