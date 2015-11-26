class ApplicationPoolsController < ApplicationController
  before_filter :check_for_cancel, :only => [:create, :update]

  load_and_authorize_resource

  def index
  	@application_pools = ApplicationPool.all
  end

  def new
  	@application_pool = ApplicationPool.new
  end

  def create
  	@application_pool = ApplicationPool.create!(params[:application_pool])
  	@application_pool.save!
    #debugger
    flash[:success] = "New application pool for #{@application_pool.year} #{@application_pool.semester}  was successfully created."
    redirect_to application_pools_path
  end

  def edit
  	@application_pool = ApplicationPool.find params[:id]
  end

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to application_pools_path
    end
  end

  def update
  	@application_pool = ApplicationPool.find params[:id]
    @application_pool.update_attributes!(params[:application_pool])
    flash[:success] = "Application pool for #{@application_pool.year} #{@application_pool.semester} was successfully updated."
    redirect_to application_pools_path
  end
end
