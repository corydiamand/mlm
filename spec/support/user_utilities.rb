include ApplicationHelper

def remove_portals(user)
  user.delete_if { |k, v| k.include?("statements") }
end

def make_statements(user)
  binding.pry
  user["statements::statements_id"] = 10
  binding.pry
end