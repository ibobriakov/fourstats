class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_i18n_locale_from_params

  def feedback
    feedback = Feedback.create(:name => params[:name], :email => params[:email], :message => params[:message])
    
    if ContactMailer.send_contact_email(feedback).deliver
      flash[:notice] = "Sent!"
    else
      flash[:notice] = "Could't send you message."
    end
    redirect_to root_path, :notice => "Thanks for Your message!"
  end

  def self.parent_categories
    collection = []
    Category.all.each do |category|
      collection << category if (category.parent.nil?)
    end
    collection
  end

private
  
  def quimby
    @foursquare ||= Foursquare::Base.new(Settings.app_id, Settings.app_secret)
  end

  def foursquare2 # uses for categories parse and in generate_categories task
    @foursquare2 ||= Foursquare2::Client.new(:client_id => Settings.app_id, :client_secret => Settings.app_secret) 
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
