module ApplicationHelper

  TOOLTIPS = { copyright_date: 'Usually the date of the first commercial release of this work',
               duration: "Please enter as mm:ss (for example: 03:30)",
               pending: "The changes made to this work are being processed" }

  IMAGES   = { plus:    "/assets/glyphicons_190_circle_plus.png",
               search:  "/assets/glyphicons_027_search.png" }

  def logo_link(path)
    link_to path do
      image_tag "/assets/mlmlogo.png", id: "logo"
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(add_image_to_name(name, :plus), '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def add_image_to_name(name, img)   # This makes the plus icon part of the Add Audio Product link
    image = image_tag "#{IMAGES[img]}" 
    return image + " " + name
  end

  def tooltip_for(key)
    content_tag :a, title: TOOLTIPS[key], class: "js-tooltip", data: { toggle: "tooltip" } do
      content_tag :i, "", class: "icon-question-sign" # question mark image
    end
  end

  def link_to_add_attachment(name)
    content_tag :div, add_image_to_name(name, :plus), class: "add_fields"
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
end
