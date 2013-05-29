# it works fine
namespace :regular do
  desc "Parsing FourSquare for its categories"

  task :generate_categories => :environment do
    @client = Foursquare2::Client.new(:client_id => 'N42V3JIXE5OZNRYFIGX2AD1UCOS3KNUD5DEKPHVXDU13E15M', :client_secret => '4FVVAOR2DRTJFZYYDEOLL304ZLZ2GE3CW4D40CKRFHBZESDT')

    @client.venue_categories.each do |first_level|
      root = Category.create(:name => first_level.name, :id_foursquare_category => first_level.id)
      root.save!

      first_level.categories.each do |second_level|
        child1 = root.children.create(:name => second_level.name, :id_foursquare_category => second_level.id)
        child1.save!

        second_level.categories.each do |third_level|
          child2 = child1.children.create(:name => third_level.name, :id_foursquare_category => third_level.id)
        end
      end
    end
  end
end