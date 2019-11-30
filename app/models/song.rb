class Song < ApplicationRecord
    validates :title, :artist_name, presence: true
    validate :release_year_present, :valid_release_year, :song_same_year
end

def release_year_present
    if self.released == true && self.release_year == nil 
        errors.add(:release_year, "must be present if 'released' is true")
    end
end

def valid_release_year
    if self.release_year.present? && self.release_year > Date.current.year
        errors.add(:release_year, "cannot be in the future")
    end
end

def song_same_year
    if Song.find_by(title: self.title) && self.release_year == Song.find_by(title: self.title).release_year
        errors.add(:title, "cannot be released more than once in the same year")
    end
end