class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    new_movie = Movie.new

    new_movie.title = params.fetch("query_title")
    new_movie.year = params.fetch("query_year")
    new_movie.duration = params.fetch("query_duration")
    new_movie.description = params.fetch("query_description")
    new_movie.image = params.fetch("query_image")
    new_movie.director_id = params.fetch("query_director_id")

    if new_movie.valid?
      new_movie.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      redirect_to("/movies", { :notice => "Movie failed to create successfully." })
    end
  end

  def destroy
      delete_id = params.fetch("path_id")
      delete_movie = Movie.where({id: delete_id}).at(0)

      delete_movie.destroy

      redirect_to("/movies", { :notice => "Movie deleted successfully"})
  end

  def update
    update_id = params.fetch("path_id")
    update_candidate = Movie.where({id: update_id}).at(0)

    update_candidate.title = params.fetch("query_title")
    update_candidate.year = params.fetch("query_year")
    update_candidate.duration = params.fetch("query_duration")
    update_candidate.description = params.fetch("query_description")
    update_candidate.image = params.fetch("query_image")
    update_candidate.director_id = params.fetch("query_director_id")

    if update_candidate.valid?
      update_candidate.save
      redirect_to("/movies", { :notice => "Movie updated successfully." })
    else
      redirect_to("/movies", { :notice => "Movie failed to update successfully." })
    end
  end
end
