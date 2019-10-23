class User < ActiveRecord::Base
    has_many :scores

    def welcome(user)
        user.create
    end
end