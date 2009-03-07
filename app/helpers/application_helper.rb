# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def standard_flashes
    output = ""
    [:success, :error, :notice].each do |kind|
      unless flash[kind].blank?
        output += content_tag(:div, flash[kind], :class => kind.to_s)
      end
    end
    output
  end
end
