class TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @teacher = Teacher.new
    respond_to do |format|
      format.html {}
      format.json { render json: { teacher: @teacher }, status: :ok }
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { teacher: @teacher }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @teacher = Teacher.new(teacher_params)
    respond_to do |format|
      if @teacher.save
        format.html { redirect_to school_path(@teacher.school) }
        format.json { render json: { teacher: @teacher }, status: :created }
      else
        format.html { render 'new', status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: 'Invalid Foreign Key' }, status: :unprocessable_entity }
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      @teacher.destroy
      format.html { redirect_to teachers_path }
      format.json { render json: {}, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def index
    @teachers = Teacher.all
    respond_to do |format|
      format.html {}
      format.json { render json: { teachers: @teachers }, status: :ok }
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { teacher: @teacher }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher }
        format.json { render json: { teacher: @teacher }, status: :ok }
      else
        format.html { render 'edit', status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def add_subject
    @teacher = Teacher.find(params[:id])
    @subject = Subject.find(params[:subject_id])
    respond_to do |format|
      @teacher.subjects << @subject
      format.html { redirect_to @teacher, status: :ok }
      format.json { render json: { subjects: @teacher.subjects }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { render html: { error: e.message }, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def add_classroom
    @teacher = Teacher.find(params[:id])
    @classroom = Classroom.find(params[:classroom_id])
    respond_to do |format|
      @teacher.classrooms << @classroom
      format.html { redirect_to @teacher, status: :ok }
      format.json { render json: { classrooms: @teacher.classrooms }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { render html: { error: e.message }, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :address, :phone_no, :gender, :school_id)
  end
end
