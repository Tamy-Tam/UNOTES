class Ycourse < ApplicationRecord
  has_many :notes

  validates :url, presence: true
  validates :url, format: { with: /^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$/,  message: "only allows youtube videos"  }
  validates :title, presence: true
end
