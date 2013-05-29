ActiveAdmin.register Venue do
  index do
    column :id
    column :name
    column "Category" do |venue|
      venue.categories.map { |c| c.name }.join('<br />').html_safe
    end
    column :address
    column :checkins_count
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :rating
      f.input :checkins_count
      f.input :users_count
      f.input :photos_count
      f.input :tips_count
      f.input :id_foursquare
      f.input :categories, :collection => ApplicationController::parent_categories  # add roles input here
    end
    f.buttons
  end

  csv do
    column :name
    column :address
    column :rating
    column :checkins_count
    column :users_count
    column("Category") {|venue| venue.categories.first.try(:name) }
    column :updated_at
  end
end
