class VolunteersController < ApplicationController
  def index
    @volunteers = User.volunteers
    @proficiency = Proficiency.new
    @subjects = Subject.all
    @roles = ApplicationRecord::ROLES
  end

  def show
    @volunteer = User.find(params[:id])
  end
end
