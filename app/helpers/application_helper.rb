module ApplicationHelper
  def foursquare_url venue
    "http://foursquare.com/v/" + venue.id_foursquare
  end

  def venues_count
    Venue.count
  end

  def category_icon category
    case category
      when "Food" then image_tag "food.png"
      when "College & University" then image_tag "college_university.png"
      when "Arts & Entertainment" then image_tag "arts_entertainment.png"
      when "Nightlife Spot" then image_tag "nightlife_spot.png"
      when "Outdoors & Recreation" then image_tag "outdoors_recreation.png"
      when "Professional & Other Places" then image_tag "professional_other_places.png"
      when "Residence" then image_tag "residence.png"
      when "Shop & Service" then image_tag "shop_service.png"
      when "Travel & Transport" then image_tag "travel_transport.png"
    end
  end

  def primary_category venue
    cat = String.new
    venue.categories.each do |category|
      cat = category.name if category.parent.nil?
    end
    if cat.nil?
      return nil
    else
      cat
    end
  end
end

