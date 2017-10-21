require 'csv'
class MenuImporter

  def initialize(options = {})
    @options = options
  end

  def csv_file
    @options[:file]
  end


  def fetch_rows_from_csv
    @items = []
    CSV.foreach(csv_file, headers: true, skip_blanks: true) do |row|
      unless row.to_hash.values.all?(&:nil?)
        @items << Menu.new(row.to_h) unless Menu.exists?(id: row['id'])
      end
    end
    @items
  end

  def items
    @items ||= fetch_rows_from_csv
  end

  def import
    Menu.import(items)
  end
end