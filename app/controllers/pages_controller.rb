# encoding: utf-8
class PagesController < ApplicationController
  require 'will_paginate/array'

  def index
 #   @ven = foursquare2.venue_tips(:ll => '50.452258,30.519814', :query => 'McDonalds')

    @venues = quimby.venues.nearby(:ll => "50.455755,30.521187") # Returns all resulting groups
    @venue  = quimby.venues.find("509beed6498e0d95ea4308d6")

    @json = Venue.order("checkins_count DESC").limit(5).to_gmaps4rails
  end

  def categories
    @categories = foursquare2.venue_categories
  end

  def specials
  end

  def rating

    @collection = []
    Category.all.each do |category|
      @collection << category if (category.parent.nil?)
    #  @collection << category if (!category.parent.nil?) && (!category.parent.parent.nil?)
    end

    @type = params[:type] || "checkins_count"
    @category_id = params[:category_id] if params[:category_id] != "all"

    @title = case @type
      when "rating"         then  "По рейтингу"
      when "checkins_count" then  "По чекинам"
      when "users_count"    then  "По количеству пользователей"
      when "photos_count"   then  "По количеству фото"
      when "tips_count"     then  "По подсказкам"
    end

    @tab_title = case @type
      when "rating"         then  "Rating"
      when "checkins_count" then  "Check-ins"
      when "users_count"    then  "Users"
      when "photos_count"   then  "Photos"
      when "tips_count"     then  "Tips"
    end

    if params[:category_id] && params[:category_id] != "all"
      @venues = Category.find(@category_id).venues.order("#{@type} DESC").all(:conditions => "#{@type} IS NOT NULL")
    else
      params[:category_id] = nil
      @venues = Venue.order("#{@type} DESC").all(:conditions => "#{@type} IS NOT NULL")
    end

    sleep 1 if request.xhr?
    
    @venues = @venues.paginate(:page => params[:page], per_page: 10)
    
    @json = @venues.to_gmaps4rails

    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    @type = 'checkins_count'
    if params[:query].length > 0
      @venues = Venue.search_by_name(params[:query])
      if !@venues.nil?
        @venues = @venues.sort {|a,b| b.checkins_count <=> a.checkins_count}
        @json = @venues.to_gmaps4rails
      else
        @venues = nil
        @message = "Ничего не найдено"
      end
    else
      redirect_to :back
    end
  end
end
