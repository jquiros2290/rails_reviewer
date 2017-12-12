class Event < ActiveRecord::Base
  validates :name, :city, :state, :date, presence: true
  validates :date, presence: true, inclusion: { in: (Date.today..Date.today+5.years) }
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :users, through: :joins
  has_many :comments
  
end
