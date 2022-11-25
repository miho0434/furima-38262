class PurchasesController < ApplicationController
  def index 
    #フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    #ApplicationRecordを継承していないため、valid?メソッドを使用
    if @purchase_form.valid?
      @purchase_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  #purchase_idをmergeに含めると、「Purchase can't be blank」が表示されるので不要
  def purchase_params
    params.require(:purchase_form)
          .permit(:postal_code, :prefecture_id, :city, :street_number, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id])
  end
end