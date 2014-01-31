# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#user_search_name').autocomplete({
    source: $('#user_search_name').data('autocomplete-source')
    focus: (event, ui) ->
      $('#user_search_name').val ui.item.label
      false
    select: (event, ui) ->
      $('#user_search_name').val ui.item.label
      $('#user_search_name_id').val ui.item.id
  })

  $("#user_search_name").focus()
