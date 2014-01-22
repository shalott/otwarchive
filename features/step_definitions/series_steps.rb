When /^I view the series "([^\"]*)"$/ do |series|
  visit series_url(Series.find_by_title!(series))
end

When /^I add (?:the work )?"([^\"]*)" to (?:the )?series "([^\"]*)"(?: as "([^"]*)")?$/ do |work_title, series_title, pseud|
  if pseud.present?
    step %{I create the pseud "#{pseud}"}
  end

  work = Work.find_by_title(work_title)
  if work.blank?
    step %{I post the work "#{work_title}"}
  end  
  step "I edit the work \"#{work_title}\""
  unless pseud.nil?
    select(pseud, :from => "work_author_attributes_ids_")
  end
  
  check("series-options-show")  
  if Series.find_by_title(series_title)
    step %{I select "#{series_title}" from "work_series_attributes_id"}
  else
    fill_in("work_series_attributes_title", :with => series_title)
  end
  click_button("Post Without Preview")
end

When /^I add (?:the work )?"([^\"]*)" to (?:the )?"(\d+)" series "([^\"]*)"$/ do |work_title, count, series_title|
  work = Work.find_by_title(work_title)
  if work.blank?
    step %{I post the work "#{work_title}"}
  end
  
  count.to_i.times do |i|
    step "I edit the work \"#{work_title}\""
    check("series-options-show")
    fill_in("work_series_attributes_title", :with => series_title + i.to_s)
    click_button("Post Without Preview")
  end
end

Then /^"([^\"]*)" should be part (\d+) of (?:the )?"([^\"]*)" series$/ do |work_title, part_num, series_title|
  work = Work.find_by_title(work_title)
  visit work_url(work)
  step %{I should see "Part #{part_num} of the #{series_title} series" within "div#series"}
  step %{I should see "Part #{part_num} of the #{series_title} series" within "dd.series"}
end
  
Then /^"([^\"]*)" should not be part of (?:the )?"([^\"]*)" series$/ do |work_title, series_title|
  work = Work.find_by_title(work_title)
  visit work_url(work)
  step %{I should not see "of the #{series_title} series"}
  series = Series.find_by_title(series_title)
  visit series_url(series)
  step %{I should not see "#{work_title}"}
end

Then /^the "([^\"]*)" series should belong to the pseud "([^\"]*)"$/ do |series_title, pseud_name|
  series = Series.find_by_title(series_title)
  visit series_url(series)
  step %{I should see "#{pseud_name}"}
end
