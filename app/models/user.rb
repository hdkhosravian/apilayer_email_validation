class User < ApplicationRecord
  validates :first_name, :last_name, :url, presence: true
  validates_format_of :url, with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i
end
