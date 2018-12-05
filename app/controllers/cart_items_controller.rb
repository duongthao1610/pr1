class CartItemsController < ApplicationController
  before_action {flash.clear}
  def index
    @pagy, @items = pagy current_user.cart_items
    @payments = Payment.all
  end

  def destroy
    current_user.cart_items.find_by(params[:id]).delete
    @pagy, @items = pagy current_user.cart_items
    flash[:success] = t ".success"
    respond_to do |format|
      format.html { redirect_to cart_items_path }
      format.js
    end
  end

  def create
    @cart_item = CartItem.new cart_item_params
    @item = CartItem.find_by cosmetic_id: cart_item_params[:cosmetic_id]
    if @item
      @item.update_attributes cart_item_params
      flash[:success] = t ".update"
    else
      @cart_item.save
      flash[:success] = t ".add"
    end
    respond_to do |format|
      format.html { redirect_to cosmetic_path(@cosmetic) }
      format.js
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit :cosmetic_id, :user_id, :quantity, :paideach
  end
end
