class Special < ActiveRecord::Base
  attr_accessible :finetext, :message

  belongs_to :venue

  validates :message, uniqueness: true
end
