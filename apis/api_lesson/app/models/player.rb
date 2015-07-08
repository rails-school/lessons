class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :country, presence: true

  def as_json(options={})
    super(only: [:name, :country, :number])
  end
end
