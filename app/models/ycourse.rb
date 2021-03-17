class Ycourse < ApplicationRecord
  has_many :notes

  validates :url, presence: true
  validates :url, format: { with: /\A(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+\Z/, message: "only allows youtube videos" }
end
