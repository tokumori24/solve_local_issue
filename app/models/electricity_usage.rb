class ElectricityUsage < ApplicationRecord
  # バリデーション
  validates :month, presence: true, inclusion: { in: 1..12 }
  validates :year, presence: true
  validates :usage, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # 年月の組み合わせで一意にする
  validates :month, uniqueness: { scope: :year, message: "この月と年のデータは既に存在します" }

  # CO2排出係数 (kg-CO2/kWh) - 日本の平均的な値
  CO2_FACTOR = 0.45

  # CO2排出量を計算するメソッド
  def co2_emission
    (usage * CO2_FACTOR).round(2)
  end

  # 月名を日本語で取得
  def month_name
    "#{month}月"
  end

  # 年月の表示
  def year_month
    "#{year}年#{month}月"
  end

  # デフォルトスコープ: 年、月の昇順でソート
  default_scope { order(year: :asc, month: :asc) }
end
