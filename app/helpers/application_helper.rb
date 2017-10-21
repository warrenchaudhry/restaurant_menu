module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", warning: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade in", role: 'alert') do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' },' arial-label': 'Close')
        concat message
      end)
    end
    nil
  end

  def attr_label(attr)
    attr.to_s.humanize.titleize
  end

  def sortable(label, attr)
    sort_direction = params[:direction]
    sort_direction_params = sort_direction == 'DESC' ? 'ASC' : 'DESC'
    sort_icon_class = if params[:sort] == attr.to_s
                        "fa fa-fw fa-sort-#{sort_direction.downcase}"
                      else
                        'fa fa-fw fa-sort unsorted'
                      end
    link_to params.except(:page, :per_page).merge(sort: attr, direction: sort_direction_params).permit(:sort, :direction) do
      concat(label)
      concat(content_tag(:i, nil, class: sort_icon_class))
    end
  end
end
