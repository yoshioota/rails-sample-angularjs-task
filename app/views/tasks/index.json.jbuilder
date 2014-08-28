json.page_info do |json|

  json.is_first_page @tasks.first_page?
  json.is_last_page @tasks.last_page?
  json.current_page @tasks.current_page
  json.num_pages @tasks.num_pages
  json.size @tasks.to_a.size
  json.total_count @tasks.total_count

  page_number_arr = []
  start_page_no = @tasks.current_page - 3 < 1 ? 1 : @tasks.current_page - 3
  end_page_no   = @tasks.current_page + 3 >= @tasks.num_pages ? @tasks.num_pages : @tasks.current_page + 3
  (start_page_no..end_page_no).each do |idd|
    page_number_arr << idd
  end
  json.page_numbers page_number_arr

  # json.per_page @tasks.per_page
end

json.tasks do |json|

  json.array!(@tasks) do |task|
    json.extract! task, :id, :title, :description, :done
    json.url task_url(task, format: :json)
  end
end
