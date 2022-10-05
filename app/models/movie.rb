class Movie < ActiveRecord::Base
  @@all_ratings = ["G", "PG", "PG-13", "R"]
  def self.all_ratings
    @@all_ratings
  end
  def self.with_ratings(ratings)
    if !ratings.nil?
      return Movie.where(rating: ratings)
    end
    return Movie.all
  end
end
