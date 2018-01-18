class ClassroomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @classroom = Classroom.new
    respond_to do |format|
      format.html {}
      format.json { render json: { classroom: @classroom }, status: :ok }
    end
  end

  def show
    @classroom = Classroom.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { classroom: @classroom }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @classroom = Classroom.create(classroom_params)
    respond_to do |format|
      if @classroom.save
        format.html { redirect_to school_path(@classroom.school) }
        format.json { render json: { classroom: @classroom }, status: :created }
      else
        format.html { render 'new', status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: 'Invalid Foreign Key' }, status: :unprocessable_entity }
    end
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    respond_to do |format|
      @classroom.destroy
      format.html { redirect_to school_path(@classroom.school) }
      format.json { render json: {}, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def index
    @classrooms = Classroom.all
    respond_to do |format|
      format.html {}
      format.json { render json: { classrooms: @classrooms }, status: :ok }
    end
  end

  def edit
    @classroom = Classroom.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { classroom: @classroom }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    @classroom = Classroom.find(params[:id])
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom }
        format.json { render json: { classroom: @classroom }, status: :ok }
      else
        format.html { render 'edit', status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def add_teacher
    @classroom = Classroom.find(params[:id])
    @teacher = Teacher.find(params[:teacher_id])
    respond_to do |format|
      @classroom.teachers << @teacher
      format.html { redirect_to classroom_path(@classroom), status: :ok }
      format.json { render json: { teachers: @classroom.teachers }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { render html: { error: e.message }, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:room_no, :class_no, :school_id, :teacher_id)
  end
end
