namespace :regular do
  task :remove_dublicates => :environment do
    Venue.all.each do |venue|
      unicals = Venue.where("name = '#{venue.name}' AND address = '#{venue.address}'")
      if unicals.count > 1
        unicals.order('checkins_count DESC').each_with_index do |non_unique_venue, iterator|
          next if iterator == 0
          venue_name = non_unique_venue.name
          puts "deleted venue #{venue_name}" if non_unique_venue.destroy
        end
      end
    end
    puts "Duplicate venues has been removed"
  end
end