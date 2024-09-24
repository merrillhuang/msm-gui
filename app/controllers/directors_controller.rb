class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    new_director = Director.new

    new_director.name = params.fetch("query_name")
    new_director.dob = params.fetch("query_dob")
    new_director.bio = params.fetch("query_bio")
    new_director.image = params.fetch("query_image")

    if new_director.valid?
      new_director.save
      redirect_to("/directors", { :notice => "Director created successfully." })
    else
      redirect_to("/directors", { :notice => "Director failed to create successfully." })
    end
  end

  def destroy
    delete_id = params.fetch("path_id")
    delete_candidate = Director.where({id: delete_id}).at(0)

    delete_candidate.destroy

    redirect_to("/directors", { :notice => "Director deleted successfully." })
  end

  def update
    update_id = params.fetch("path_id")
    update_candidate = Director.where({id: update_id}).at(0)

    update_candidate.name = params.fetch("query_name")
    update_candidate.dob = params.fetch("query_dob")
    update_candidate.bio = params.fetch("query_bio")
    update_candidate.image = params.fetch("query_image")

    if update_candidate.valid?
      update_candidate.save
      redirect_to("/directors/#{update_id}", { :notice => "Director updated successfully." })
    else
      redirect_to("/directors/#{update_id}", { :notice => "Director failed to update successfully." })
    end
  end
end
