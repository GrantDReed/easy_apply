class JobsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @user = User.find(session[:user_id])
    if @user.employer
      @job = Job.new(job_params)
      if @job.save
        @user << @job
        flash[:success] = "Job posted!"
        redirect_to @job
      else
        render 'new'
      end
    else
      applied = @user.jobs.find(params[:id]).count > 0
      unless applied
        @user << Job.find(params[:id])
      end
    end

  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "Job post updated!"
      redirect_to @job
    else
      render 'edit'
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  private

    def job_params
      params.require(:job).permit(:title, :description)
    end
end
