class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :redirect_root, only: [:index, :create] # 出品者が自身の商品の購入ページに行くとトップへ戻る。
  before_action :authenticate_user!

  def index
    # フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    # ApplicationRecordを継承していないため、valid?メソッドを使用
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_root
    redirect_to root_path if (current_user == @item.user) || (current_user != @item.user && @item.purchase.present?)
  end

  # purchase_idをmergeに含めると、「Purchase can't be blank」が表示されるので不要
  def purchase_params
    params.require(:purchase_form)
          .permit(:postal_code, :prefecture_id, :city, :street_number, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,              # 商品の値段
      card: purchase_params[:token],    # トークン化されたカード情報
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
