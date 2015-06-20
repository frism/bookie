class ItemsController < ApplicationController

  before_filter :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def new
    @item ||= Item.new
    render
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: "#{@item.name} was successfully created"
    else
      flash[:alert] = 'Something went wrong, try again?'
      render 'new'
    end
  end

  def show
  end

  def edit
    if @item
      render
    else
      redirect_to items_path, alert: 'Item not found'
    end
  end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] = "The #{@item.name} was successfully updated."
      redirect_to item_path(@item)
    else
      render 'edit'
      flash[:alert] = 'Something went wrong, try again?'
    end
  end

  def destroy
    if @item.destroy!
      redirect_to items_path, flash[:notice] = "Item destroyed."
    else
      redirect_to items_path, flash[:alert] = "Item delete failed."
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :code, :quantity, :status)
  end

end
