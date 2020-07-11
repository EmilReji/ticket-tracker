module ApplicationHelper
  def get_tag_str(ticket)
    return ticket.tags.order(:value).map(&:value).join(', ')
  end

  def shorten_desc(project, len = 10)
    if project.description.length > len
      return project.description[0..10] + '...'
    else
      return project.description
    end
  end
end
