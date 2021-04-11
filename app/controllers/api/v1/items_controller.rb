class Api::V1::ItemsController < ApplicationController
  before_action :set_admin
  # before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    @items = @admin.items

    render json: @items
  end

  # GET /items/1
  def show
    @item = Item.find(params['id'])
    render json: @item
  end

  # POST /items
  def create
    # binding.pry
    @item = @admin.items.new(item_params)
    if @item.save
      render json: @admin
      # render json: @item, status: :created, location: @item
    else
      # render json: @item.errors, status: :unprocessable_entity
      render json: { error: "Balance too low." } #=> in video
    end
  end

  # PATCH/PUT /items/1
  def update
    binding.pry 
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    # binding.pry
    @item = Item.find(params['id'])
    @item.destroy
    @admin = Admin.find(@item.admin_id)
    render json: @admin
    
    # @item = Item.find(params["id"])
    # @admin = Admin.find(@item.admin_id)
    # if @admin.update_balance_on_delete(@item)
    #   @item.destroy
    #   render json: @admin
    # else
    #   render json: @item.errors, status: :unprocessable_entity
    # end
    # it matters that it's an instance variable, video at approx. 34:20
  end

  private

  def set_admin
    @admin = Admin.find(params[:admin_id])
    # @item = Item.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  # def set_item
  #   @item = item.find(params[:id])
  # end

  # Only allow a trusted parameter "white list" through.
  def item_params
    params.require(:item).permit(:admin_id, :name, :image_url, :description, :price)
  end
end
