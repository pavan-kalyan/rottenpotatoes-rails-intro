class MoviesController < ApplicationController

  before_action :setup

  def setup
    @all_ratings = Movie.all_ratings
    if not session[:ratings].nil? and not session[:ratings].empty?
      @ratings_to_show = session[:ratings].keys
    else
      @ratings_to_show = []
    end
    @classes ={}
    if not session[:sort].nil?
      @current_sort = session[:sort]
      @classes = {@current_sort => "hilite .text-warning bg-warning"}
    else
      # if not sort is applicable reset classes
      @classes = {}
      @current_sort = ""
    end
  end
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # puts params
    if params[:home]
      session[:sort] = params[:sort]
      session[:ratings] = params[:ratings]
    end
    if not session[:ratings].nil? and not session[:ratings].empty?
      @ratings_to_show = session[:ratings].keys
    else
      @ratings_to_show = []
    end
    if not session[:sort].nil?
      @current_sort = session[:sort]
      @classes = {@current_sort => "hilite .text-warning bg-warning"}
    else
      # if not sort is applicable reset classes
      @classes = {}
    end
    @movies = Movie.with_ratings(@ratings_to_show, @current_sort)
  end

  def new
    # default: render 'new' template
    @all_ratings = Movie.all_ratings
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
