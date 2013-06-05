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

  if $('#view-toggle').length > 0
    Morris.Line
      element: 'statements-chart'
      data: $('#statements-chart').data('statements')
      xkey: 'date'
      ykeys: ['amount']
      labels: ['Royalty income']
      preUnits: '$'
      lineColors: ['#0E0844']

  $('.statement-record:odd').css("background-color", "#eaeaea")
  $('#statements-chart').toggle()


  $('#view-toggle').click ->
    $('#statements-chart').toggle()
    $('.statements').toggle()
    if $('#view-toggle').text() == 'View graph'
      $('#view-toggle').empty().append("View list")
      $('#chart-head').empty().append("Income detail")
    else
      $('#view-toggle').empty().append("View graph")
      $('#chart-head').empty().append("Statement detail")

