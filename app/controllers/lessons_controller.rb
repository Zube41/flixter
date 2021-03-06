class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]

  def show
  end

  private
  
  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
  
  def require_currently_enrolled
    if ! current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), :alert => "You must be enrolled in class to view the lesson"
    end
  end
end