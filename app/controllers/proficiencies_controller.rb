class ProficienciesController < ApplicationController
  before_action :set_volunteer, except: :destroy

  def new
    @proficiency = Proficiency.new
    @subjects = Subject.all
    @roles = ApplicationRecord::ROLES
  end

  def create
    @proficiency = Proficiency.new(proficiency_params)
    @proficiency.user = @volunteer

    if @proficiency.save
      redirect_to volunteers_path
    else
      render :new
    end
  end

  def destroy
    @proficiency = Proficiency.find(params[:id])
    @proficiency.destroy
    redirect_to volunteers_path
  end

  private

  def set_volunteer
    @volunteer = User.find(params[:volunteer_id])
    # volunteer_id is actually the user_id
  end

  def proficiency_params
    params.require(:proficiency).permit(:volunteer_id, :subject_id, :role)
  end
end
