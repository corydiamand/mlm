# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $(".audio-product-count:last").text("Audio product " + $(".audio-product-fields").length)
    event.preventDefault()

  $(document).ready ->
    $('.audio-product-count').each((index) ->
      $(this).text("Audio product " + (index + 1)))

  error_fields = $(".field_with_errors")
  error_fields.each( ->
    if $(this).parent().hasClass("input-append")
      $(this).append $(".add-on"))