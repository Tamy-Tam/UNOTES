class Note < ApplicationRecord
  belongs_to :user
  belongs_to :ycourse

  has_many :favourite_notes

  acts_as_taggable_on :tags
end
