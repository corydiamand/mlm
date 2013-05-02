module ApplicationHelper

  def logo_link(path)
    link_to path do
      image_tag "/assets/mlmlogo.png", id: "logo"
    end
  end
end
