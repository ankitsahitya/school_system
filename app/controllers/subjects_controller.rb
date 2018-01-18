class SubjectsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @subject = Subject.new
    respond_to do |format|
      format.html {}
      format.json { render json: { subject: @subject }, status: :ok }
    end
  end

  def show
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { subject: @subject }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @subject = Subject.new(subject_params)
    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject }
        format.json { render json: { subject: @subject }, status: :created }
      else
        format.html { render 'new', status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subject = Subject.find(params[:id])
    respond_to do |format|
      @subject.destroy
      format.html { redirect_to subjects_path }
      format.json { render json: {}, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def index
    @subjects = Subject.all
    respond_to do |format|
      format.html {}
      format.json { render json: { subjects: @subjects }, status: :ok }
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { subject: @subject }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    @subject = Subject.find(params[:id])
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject }
        format.json { render json: { subject: @subject }, status: :ok }
      else
        format.html { render 'edit', status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def add_teacher
    @subject = Subject.find(params[:id])
    @teacher = Teacher.find(params[:teacher_id])
    respond_to do |format|
      @subject.teachers << @teacher
      format.html { redirect_to @subject, status: :ok }
      format.json { render json: { teachers: @subject.teachers }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { render html: { error: e.message }, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def add_student
    @subject = Subject.find(params[:id])
    @student = Student.find(params[:student_id])
    respond_to do |format|
      @subject.students << @student
      format.html { redirect_to @subject, status: :ok }
      format.json { render json: { students: @subject.students }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { render html: { error: e.message }, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name)
  end
end
