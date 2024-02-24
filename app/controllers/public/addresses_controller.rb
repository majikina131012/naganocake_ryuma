class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_address, only: [:edit, :update, :destroy]
  
  def index
    @address = Address.new
    @addresses = current_customer.addresses
    # @addresses = Address.all
  end

  def create
    @addresses = current_customer.addresses
    # @address = @addresses.new(address_params)
    # こう書くと、save出来なかった時に、@addressesの最後に空レコードが入り、エラーになる。
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    @address.save ? (redirect_to addresses_path) : (render :index)
    # redirect_to addresses_path
  end

  def edit
    # @address = Address.find(params[:id])
  end

  def update
    # address = Address.find(params[:id])
    # address.update(address_params)
    # redirect_to addresses_path
    @address.update(address_params) ? (redirect_to addresses_path) : (render :edit)
  end

  def destroy
    # address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private
  
  def ensure_address
    @addresses = current_customer.addresses
    @address = @addresses.find_by(id: params[:id])
    redirect_to addresses_path unless @address
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
