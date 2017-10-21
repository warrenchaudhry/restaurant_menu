class Menu < ApplicationRecord
  self.primary_key = "id"
  before_create :set_id
  def self.search(keyword)
    searchable_cols = %w(name sponsor place venue event location)
    qry_string = ''
    searchable_cols.each do |attr|
      qry_string += "LOWER(TRIM(#{attr})) LIKE :keyword"
      qry_string += " OR " if attr != searchable_cols.last
    end
    result = where(qry_string, keyword: "%#{keyword.strip.downcase}%")
    result
  end

  private
  def set_id
    if self.id.blank?
      last_id = Menu.pluck(:id).max || 0
      new_id = last_id += 1
      self.id = new_id
    end
  end
end
