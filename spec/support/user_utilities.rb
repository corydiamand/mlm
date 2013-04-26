include ApplicationHelper

def remove_portals(user)
  user.delete_if { |k, v| k.include?("statements") }
end