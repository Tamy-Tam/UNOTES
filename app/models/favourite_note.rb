class FavouriteNote < ApplicationRecord
  belongs_to :user
  belongs_to :note
end
