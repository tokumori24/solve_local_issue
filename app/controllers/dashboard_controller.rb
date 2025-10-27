class DashboardController < ApplicationController
  def index
    # 全ての電気使用量データを取得
    @electricity_usages = ElectricityUsage.all

    # 新規作成用のインスタンス
    @electricity_usage = ElectricityUsage.new

    # グラフ用のデータを準備
    @chart_data = prepare_chart_data
  end

  private

  def prepare_chart_data
    # 現在の年のデータを取得
    current_year = Time.current.year
    usages = ElectricityUsage.where(year: current_year).index_by(&:month)

    # 12ヶ月分のデータを準備
    months = (1..12).map do |month|
      usage = usages[month]
      {
        month: "#{month}月",
        usage: usage&.usage&.to_f || 0,
        co2: usage&.co2_emission || 0
      }
    end

    months
  end
end
