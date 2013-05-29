class Feedback < ActiveRecord::Base
  attr_accessible :email, :message, :name

  validates :name,  :presence => true,
                    :length => {:minimum => 1, :maximum => 50}

  validates :message,   :presence => true,
                        :length => {:minimum => 10, :maximum => 50}

  validates :email, :presence => true,
                    :length => {:minimum => 3, :maximum => 50},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
end
