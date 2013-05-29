namespace :regular do
  desc "Updating venues from foursquare"

  task :update_venues => :environment do
    foursquare = Foursquare::Base.new(Settings.app_id, Settings.app_secret)

    Venue.order('updated_at ASC').each do |venue|

      puts "Processing Venue No #{venue.id}..........................................................................."
      
      begin
        upd = foursquare.venues.find(venue.id_foursquare)
        
        puts "updated name"           if venue.update_attributes(:name => upd.name)
        
        if (!upd.json['location']['city'].nil?)&&(!upd.json['location']['address'].nil?)
          puts "updating address"
          venue.try(:update_attributes, :address =>  "#{upd.json['location']['city']},"+
                                                 " #{upd.json['location']['address']}")
          #rescue Exception => e
          #  puts e
            #puts "venue destroyed" if venue.destroy
          #  sleep 1
          #  next
          #end
        elsif (!upd.json['location']['city'].nil?)||(!upd.json['location']['address'].nil?)
          puts "updating address"
          venue.update_attributes!(:address =>  "#{upd.json['location']['city']}"+
                                                "#{upd.json['location']['address']}")
        elsif (upd.json['location']['city'].nil?)&&(upd.json['location']['address'].nil?)
          puts "Empty address, venue deleted"
          sleep 1
          venue.destroy
          next
        end
        puts "updated rating"         if venue.update_attributes(:rating => upd.json["rating"])
        puts "updated checkins_count" if venue.update_attributes(:checkins_count => upd.stats["checkinsCount"])
        puts "updated users_count"    if venue.update_attributes(:users_count => upd.stats["usersCount"])
        puts "updated tips_count"     if venue.update_attributes(:tips_count => upd.json["tips"]["count"])
        puts "updated photos_count"   if venue.update_attributes(:photos_count => upd.photos_count)
        puts "updated latitude"       if venue.update_attributes(:latitude => upd.json["location"]["lat"])
        puts "updated longitude"      if venue.update_attributes(:longitude => upd.json["location"]["lng"])
        #venue.categories.delete_all
        upd.categories.each do |category|
          begin
            cat = Category.find_or_create_by_name(category.name)
            if cat.parent.nil?
              main = cat
            elsif cat.parent && cat.parent.parent.nil?
              main = cat.parent
            elsif cat.parent && !cat.parent.parent.nil?
              main = cat.parent.parent
            end

            venue.categories << main unless venue.categories.include?(main)

          rescue ActiveRecord::RecordNotUnique
            puts "Category already exists in venue.categories"
          end
        end
        venue.updated_at = Time.now
        if venue.save
          puts "Successfully updated venue ID:#{venue.id}"
        else
          puts "Something wrong with venue ID:#{venue.id}"
        end
      rescue Foursquare::Error
        puts "Cant find this venue on Foursquare"
        if venue.destroy
          puts "-------venue destroyed"
        end
      end
      sleep 1
    end
  end
end
