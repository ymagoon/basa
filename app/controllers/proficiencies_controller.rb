class ProficienciesController < ApplicationController
  before_action :set_volunteer

  def new
    @proficiency = Proficiency.new
    @subjects = Subject.all
    # @roles = ROLES
  end

  def create
    @proficiency = Proficiency.new(proficiency_params)
    @proficiency.volunteer = @volunteer

    if @proficiency.save
      redirect_to volunteers_path
    else
      render :new
    end
  end

  def destroy
  end

  private

  def set_volunteer
    @volunteer = User.find(params[:user_id])
  end

  def proficiency_params
    params.require(:proficiencies).permit(:user_id, :subject_id, :role)
  end
end
