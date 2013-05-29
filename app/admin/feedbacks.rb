ActiveAdmin.register Feedback do
  index do
    column :email
    column :name
    column :message
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :message
    end
    f.buttons
  end
end
