class Good < ActiveRecord::Base
  attr_accessible :name, :notes, :place_name, :price
  validates :name, :price, presence: true
  validates :price, numericality: {only_integer: true, greater_than: 0}

  belongs_to :place

  searchable do
    text :name, boost: 5
    text :notes
    integer :price
  end

  def place_name
    place.name if place
  end

  def place_name=(name)
    self.place = Place.find_or_create_by_name(name) unless name.blank?
  end
end
