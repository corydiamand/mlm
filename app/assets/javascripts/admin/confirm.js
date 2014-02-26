jQuery(document).ready(function() {

	$('input[data-confirm]').click(function() {
	  var confirm1 = confirm('Are you sure?');
	  if (confirm1 === true) {
	    return confirm('Are you really sure?');
	  }
	  return false;
	})
});