require 'csv'
 
CSV.generate do |csv|
  csv_column_names = ["日付","出社時間","退社時間","備考"]
  csv << csv_column_names
  @works.each do |work|
    csv_column_values = [
      work.day,
      work.start_time,
      work.end_time,
      work.note,
    ]
    csv << csv_column_values
  end
end