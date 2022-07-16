class Article < ApplicationRecord
    validates :external_id, :title, :description, :section, :expiry,  presence: true
    validates :current, inclusion: [true, false]
end
