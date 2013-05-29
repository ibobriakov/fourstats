namespace :regular do
  task :create_venues => :environment do
    File.open('public/parsed_uniq.txt') do |file|
      file.each do |line|
        venue = Venue.new(:id_foursquare => line.chomp)

        if venue.save
          puts "venue id:#{venue.id} has been created"
        else
          puts "something wrong"
        end
      end
    end
    puts "Venues are created from IDs successfully"
  end
end