class Category < ActiveRecord::Base
  include ActsAsTree

  attr_accessible :name, :id_foursquare_category, :name_ru

  acts_as_tree :order => 'name'

  validates :name, presence: true
  validates :id_foursquare_category, presence: true
  validates_uniqueness_of :id_foursquare_category

  has_and_belongs_to_many :venues
end
