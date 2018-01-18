class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :classroom
  has_and_belongs_to_many :subjects
  validates :school_id, :classroom_id, :name, :address, :phone_no, :gender, presence: true
  validates :phone_no, length: { in: 10..15 }, numericality: { only_integer: true }
  validates :gender, inclusion: { in: %w[male female] }
end
