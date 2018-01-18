class Classroom < ActiveRecord::Base
  belongs_to :school
  has_many :students
  has_and_belongs_to_many :teachers
  validates :school_id, :room_no, :class_no, presence: true
  validates :class_no, :room_no, numericality: { only_integer: true }
  validates :class_no, numericality: { greater_than: 0, less_than: 13 }
end
