module ApplicationHelper
=begin
  def display_datetime(dt)
    if is_logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime("%m/%d/%Y %l:%M%P %Z") # 03/14/2013 9:09pm
  end

=end
end
