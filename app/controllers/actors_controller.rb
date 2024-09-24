class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    new_actor = Actor.new

    new_actor.name = params.fetch("query_name")
    new_actor.dob = params.fetch("query_dob")
    new_actor.bio = params.fetch("query_bio")
    new_actor.image = params.fetch("query_image")

    if new_actor.valid?
      new_actor.save
      redirect_to("/actors", { :notice => "Actor created successfully." })
    else
      redirect_to("/actors", { :notice => "Actor failed to create successfully." })
    end
  end

  def destroy
    delete_id = params.fetch("path_id")
    delete_candidate = Actor.where({id: delete_id}).at(0)

    delete_candidate.destroy

    redirect_to("/actors", { :notice => "Actor deleted successfully." })
  end
end
