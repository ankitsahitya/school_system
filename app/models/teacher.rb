class Teacher < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :classrooms
  validates :school_id, :name, :address, :phone_no, :gender, presence: true
  validates :phone_no, length: { in: 10..15 }, numericality: { only_integer: true }
  validates :gender, inclusion: { in: %w[male female] }
end
