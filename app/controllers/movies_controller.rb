class MoviesController < ApplicationController

  def index
    @movies= Movie.all 
    if params[:query]
      # @movies = Movie.where('title LIKE :search OR director LIKE :search', search: key)
      @movies = Movie.find_by_name(params[:query])
      if @movies.count==0
        @movies = Movie.all
      end
    end

    if params[:value] == "Under 90 minutes"
      # @movies = Movie.where("runtime_in_minutes <= ?",90)
      @movies = Movie.less_than_90 
    elsif params[:value] == "Between 90 and 120 minutes" 
      @movies= Movie.between_90_to_120 
      # @movies = Movie.where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?",90, 120)
    elsif params[:value] == "Over 120 minutes"
      @movies = Movie.over_120
      # @movies = Movie.where("runtime_in_minutes > ?",120)
    end
  end


  # def duration_search  
  #   if params[:value] == "Under 90 minutes"
  #     @movies = Movie.where("runtime_in_minutes <= ?",90)
  #   elsif params[:value] == "Between 90 and 120 minutes" 
  #     @movies = Movie.where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?",90, 120)
  #   elsif params[:value] == "Over 120 minutes"
  #     @movies = Movie.where("runtime_in_minutes > ?",120)
  #   end
  # end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end
  def create 
    @movie = Movie.new(movie_params)
    if @movie.save 
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else 
      render :new 
    end
  end
  def update 
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else 
      render :edit 
    end
  end

  def destroy 
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path 
  end

  protected 

  def movie_params 
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description , :image 
      )
  end
end
