class ElectricityUsagesController < ApplicationController
  def create
    @electricity_usage = ElectricityUsage.new(electricity_usage_params)

    if @electricity_usage.save
      redirect_to root_path, notice: "#{@electricity_usage.year_month}のデータを追加しました！"
    else
      redirect_to root_path, alert: "エラー: #{@electricity_usage.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @electricity_usage = ElectricityUsage.find(params[:id])
    if @electricity_usage
      @electricity_usage.destroy
      redirect_to root_path, notice: "#{@electricity_usage.year_month}のデータを削除しました。"
    else
      redirect_to root_path, alert: "データが見つかりませんでした。"
    end
  end

  private

  def electricity_usage_params
    params.require(:electricity_usage).permit(:month, :year, :usage)
  end
end
