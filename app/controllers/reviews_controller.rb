class ReviewsController < ApplicationController
    before_filter :has_moviegoer_and_movie, :only => [:new, :create]
    protected
    def has_moviegoer_and_movie
        unless current_moviegoer
            flash[:warning] = 'You must be logged in to create a review.'
            redirect_to :back
        end
        unless (@movie = Movie.find(params[:movie_id]))
            flash[:warning] = 'Review must be for an existing movie.'
            redirect_to movies_path
        end
    end
  
    public

    def create
        current_moviegoer.reviews << @movie.reviews.build(review_params)
        redirect_to movie_path(@movie)
    end
  
    def edit
        @movie = Movie.find params[:movie_id]
        @review = Review.find params[:id]
    end
  
    def update
        @movie = Movie.find params[:movie_id]
        @review = Review.find params[:id]
        @review.update_attributes!(review_params)
        flash[:notice] = "#{@movie.title} review was successfully updated."
        redirect_to movie_path(@movie)
    end
  
    def destroy
        @movie = Movie.find params[:movie_id]
        @review = Review.find params[:id]
        @review.destroy
        flash[:notice] = "Review : '#{ @review.comments}' deleted."
        redirect_to movie_path(@movie)
    end

    private
    def review_params
        params.require(:review).permit(:potatoes, :comments, :moviegoer, :movie)
    end
  end