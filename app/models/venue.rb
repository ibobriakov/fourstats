class Venue < ActiveRecord::Base

  include PgSearch
  pg_search_scope   :search_by_name, :against => :name,
                    :using => {
                      :tsearch => {:prefix => true}
                    }

  attr_accessible :checkins_count, :description, :name, :photos_count,
                  :rating, :tips_count, :users_count, :id_foursquare,
                  :address, :latitude, :longitude, :category_ids

  validates :id_foursquare, uniqueness: true
  validates :id_foursquare, presence:   true

  has_many :specials

  has_and_belongs_to_many :categories

  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}" 
  end

  def gmaps4rails_title
      "#{self.name}"
  end
  def gmaps4rails_infowindow
    "<strong>#{self.name}</strong><br>
     #{self.address}"
  end

  def gmaps4rails_marker_picture
  {
#    "picture" => '/assets/ajax-loader.gif'         # string,  mandatory
#    "width" =>  ,          # integer, mandatory
#    "height" => ,          # integer, mandatory
  }
  end
  
  def gmaps4rails_sidebar
    "Sidebar" #put whatever you want here
  end

end
