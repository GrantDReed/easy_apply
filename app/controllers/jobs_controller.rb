class JobsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @user = User.find(session[:user_id])
    @jobs = Job.all
    @employers = User.where(employer: true)
  end

  def new
    @job = Job.new
  end

  def create
    @user = User.find(session[:user_id])
    if @user.employer
      @job = Job.new(job_params)
      if @job.save
        @user.jobs << @job
        flash[:success] = "Job posted!"
        redirect_to @job
      else
        render 'new'
      end
    else
      unless @user.jobs.exists?(params[:id])
        @job = Job.find(params[:id])
        @user.jobs << @job
      end
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "Job post updated!"
      redirect_to job
    else
      render 'edit'
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy
    redirect_to user_path(current_user)
  end

  private

    def job_params
      params.require(:job).permit(:title, :description)
    end
end
