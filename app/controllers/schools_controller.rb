class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @school = School.new
    respond_to do |format|
      format.html {}
      format.json { render json: { school: @school }, status: :ok }
    end
  end

  def show
    @school = School.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { school: @school }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @school = School.new(school_params)
    respond_to do |format|
      if @school.save
        format.html { redirect_to @school }
        format.json { render json: { school: @school }, status: :created }
      else
        format.html { render 'new', status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @school = School.find(params[:id])
    respond_to do |format|
      @school.destroy
      format.html { redirect_to schools_path }
      format.json { render json: {}, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def index
    @schools = School.all
    respond_to do |format|
      format.html {}
      format.json { render json: { schools: @schools }, status: :ok }
    end
  end

  def edit
    @school = School.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { school: @school }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    @school = School.find(params[:id])
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school }
        format.json { render json: { school: @school }, status: :ok }
      else
        format.html { render 'edit', status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :address, :phone_no, :code)
  end
end
