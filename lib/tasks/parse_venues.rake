require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :regular do
  desc "Parsing FourSquare for Venues"

  task :parse_venues => :environment do |t, args|
    foursquare = Foursquare::Base.new(Settings.app_id, Settings.app_secret)
    i = 0
    
    (50.368422..50.437538).step(0.001) do |lat|
      (30.519107..30.655464).step(0.001) do |lon|
        
        i += 1
        
        venues = foursquare.venues.nearby(:ll => "#{lat},#{lon}")
        
        venues.each do |venue|
          new_venue = Venue.new(:id_foursquare => venue.id)
          if new_venue.save
            puts "Created New Venue"
          else
          #  File.open('public/parsed.txt', 'a') do |f|
              puts new_venue.errors.full_messages#f.puts new_venue.errors.full_messages
            #end
          end
        end

        sleep 1
        puts "STEP: #{i.to_s}"
      end
    end
    puts "Task done!"
  end
end

#severo-zapad: 50.567538,30.319107 shag: 0.02
#yugo-vostok:  50.238422,30.835464

