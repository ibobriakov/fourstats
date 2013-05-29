namespace :regular do
  desc "Updating venues from foursquare"

  task :update_by_id => :environment do
    
    venue = Venue.find 2599
    foursquare = Foursquare::Base.new(Settings.app_id, Settings.app_secret)


    upd = foursquare.venues.find(venue.id_foursquare)
    
    puts "updated name"           if venue.update_attributes(:name => upd.name)
    puts "updated rating"         if venue.update_attributes(:rating => upd.json["rating"])
    puts "updated checkins_count" if venue.update_attributes(:checkins_count => upd.stats["checkinsCount"])
    puts "updated users_count"    if venue.update_attributes(:users_count => upd.stats["usersCount"])
    puts "updated tips_count"     if venue.update_attributes(:tips_count => upd.json["tips"]["count"])
    puts "updated photos_count"   if venue.update_attributes(:photos_count => upd.photos_count)

    if venue.save
      puts "Successfully updated venue ID:#{venue.id}"
    else
      puts "Something wrong with venue ID:#{venue.id}"
    end
    sleep rand(2..3)
  end
end