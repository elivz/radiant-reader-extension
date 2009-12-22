class Note < ActiveRecord::Base
  
  belongs_to :reader
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  default_scope :order => 'updated_at DESC, created_at DESC'
  
  validates_presence_of :title
  
end
