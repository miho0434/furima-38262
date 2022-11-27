class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update]
  # 出品者以外のユーザーが、出品者専用のページに遷移できないよう設定
  before_action :redirect_root, except: [:index, :new, :create, :show, :destroy]

  def index
    @items = Item.order('id DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @items = Item.includes(:user)
      render :new
    end
  end

  def show
    # set_itemにて@itemは定義済み
  end

  def edit
    # set_itemにて@itemは定義済み
  end

  def update
    # set_itemにて@itemは定義済み
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else

      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    redirect_to root_path if item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id,
                                 :status_id, :delivery_charge_burden_id, :prefecture_id,
                                 :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_root
    redirect_to root_path unless current_user == @item.user
  end
end
