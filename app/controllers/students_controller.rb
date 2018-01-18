class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @student = Student.new
    respond_to do |format|
      format.html {}
      format.json { render json: { student: @student }, status: :ok }
    end
  end

  def show
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { student: @student }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to classroom_path(@student.classroom) }
        format.json { render json: { student: @student }, status: :created }
      else
        format.html { render 'new', status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: 'Invalid Foreign Key' }, status: :unprocessable_entity }
    end
  end

  def destroy
    @student = Student.find(params[:id])
    respond_to do |format|
      @student.destroy
      format.html { redirect_to classroom_path(@student.classroom) }
      format.json { render json: {}, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def index
    @students = Student.all
    respond_to do |format|
      format.html {}
      format.json { render json: { students: @students }, status: :ok }
    end
  end

  def edit
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { student: @student }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    @student = Student.find(params[:id])
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student }
        format.json { render json: { student: @student }, status: :ok }
      else
        format.html { render 'edit', status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def add_subject
    @student = Student.find(params[:id])
    @subject = Subject.find(params[:subject_id])
    respond_to do |format|
      @student.subjects << @subject
      format.html { redirect_to @student, status: :ok }
      format.json { render json: { subjects: @student.subjects }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { render html: { error: e.message }, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :address, :phone_no, :gender, :school_id, :classroom_id)
  end
end
