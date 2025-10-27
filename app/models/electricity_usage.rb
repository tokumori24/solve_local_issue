class ElectricityUsage
  include ActiveModel::Model
  include ActiveModel::Attributes

  # 属性定義
  attribute :id, :integer
  attribute :year, :integer
  attribute :month, :integer
  attribute :usage, :float

  # バリデーション
  validates :month, presence: true, inclusion: { in: 1..12 }
  validates :year, presence: true
  validates :usage, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # CO2排出係数 (kg-CO2/kWh) - 日本の平均的な値
  CO2_FACTOR = 0.45

  # クラス変数でデータを保持（メモリストレージ）
  @@data = []
  @@next_id = 1

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

  # 保存メソッド
  def save
    return false unless valid?

    # 年月の重複チェック
    if self.class.exists?(year: year, month: month, exclude_id: id)
      errors.add(:month, "この月と年のデータは既に存在します")
      return false
    end

    if id
      # 更新
      index = @@data.find_index { |record| record[:id] == id }
      @@data[index] = to_hash if index
    else
      # 新規作成
      self.id = @@next_id
      @@next_id += 1
      @@data << to_hash
    end
    true
  end

  # 削除メソッド
  def destroy
    @@data.reject! { |record| record[:id] == id }
    true
  end

  # ハッシュに変換
  def to_hash
    {
      id: id,
      year: year,
      month: month,
      usage: usage
    }
  end

  # クラスメソッド: 全件取得
  def self.all
    @@data.sort_by { |r| [ r[:year], r[:month] ] }.map { |record| from_hash(record) }
  end

  # クラスメソッド: 条件検索
  def self.where(conditions)
    results = @@data.select do |record|
      conditions.all? { |key, value| record[key] == value }
    end
    results.map { |record| from_hash(record) }
  end

  # クラスメソッド: ID検索
  def self.find(id)
    record = @@data.find { |r| r[:id] == id.to_i }
    record ? from_hash(record) : nil
  end

  # クラスメソッド: 存在チェック
  def self.exists?(year:, month:, exclude_id: nil)
    @@data.any? do |record|
      record[:year] == year &&
      record[:month] == month &&
      record[:id] != exclude_id
    end
  end

  # クラスメソッド: データをリセット（テスト用）
  def self.reset!
    @@data = []
    @@next_id = 1
  end

  # ハッシュからインスタンスを作成
  def self.from_hash(hash)
    new(hash)
  end

  # persisted?メソッド（form_withで必要）
  def persisted?
    id.present?
  end
end
