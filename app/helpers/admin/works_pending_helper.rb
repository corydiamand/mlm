module Admin::WorksPendingHelper

  def not_provided
    content_tag :div, "not provided", class: "not-provided" 
  end
end
