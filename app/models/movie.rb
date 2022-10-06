class Movie < ActiveRecord::Base
  @@all_ratings = ["G", "PG", "PG-13", "R"]
  def self.all_ratings
    @@all_ratings
  end
  def self.with_ratings(ratings, order)
    
    if !ratings.nil? and !ratings.empty?
      result = Movie.where(rating: ratings)
    else
      result = Movie.all
    end

    if !order.nil?
      result = result.order(order)
    end
    return result

  end
end
