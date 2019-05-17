class Owner < ActiveRecord::Base
  has_many :pets

  def pet_count
    pets.count
  end
end