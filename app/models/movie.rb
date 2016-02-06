class Movie < ActiveRecord::Base 
  has_many :reviews
  mount_uploader :image, ImageUploader
  
  validates :title,
  presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image , 
  presence: true 

  validates :release_date,
    presence: true

    validate :release_date_is_in_the_past

    scope :find_by_name, -> (query) { where("title LIKE ? OR director LIKE ?", query,query) }

    scope :less_than_90, -> { where("runtime_in_minutes <= ?",90)}
    scope :between_90_to_120, -> {where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?",90, 120)}
    scope :over_120, -> {where("runtime_in_minutes > ?",120)}


  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date >Date.today
    end
  end
end
