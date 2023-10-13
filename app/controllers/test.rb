# Module for handling movie creation
module MovieCreation
    def create_new_movie
      params_title = params[:movie][:title]
  
      if Movie.where(title: params_title ).empty?
        movie = Movie.create!(movie_params)
        flash[:notice] = "#{movie.title} was successfully created."
      else
        flash[:notice] = "Movie '#{ params_title }' already exists."
      end
  
      redirect_to movies_path
    end
  end
  
  # Module for handling movie updates
  module MovieUpdate
    def update_movie
      movie = find_movie_by_id
      movie.update_attributes!(movie_params)
      flash[:notice] = "#{movie.title} was successfully updated."
      redirect_to movie_path
    end
  end
  
  # Module for handling movie deletions
  module MovieDeletion
    def delete_movie
      movie = find_movie_by_id
      movie.destroy
      flash[:notice] = "Movie '#{movie.title}' deleted."
      redirect_to movies_path
    end
  end
  
  # Controller of movie 
  class MoviesController < ApplicationController
    include MovieCreation
    include MovieUpdate
    include MovieDeletion
  
    before_action :authenticate_moviegoer!, except: [:show, :index, :force_index_redirect]
  
    def show
      @movie = find_movie_by_id
    end
  
    def index
      load_all_ratings
      load_movies_with_ratings_and_sort
      remember_settings_for_next_time
    end
  
    # ... (ต่อไป)
  
    private
  
    # (ฟังก์ชันอื่น ๆ ที่ไม่ได้ถูกแยกออกไปใน Module)
  
  end
  