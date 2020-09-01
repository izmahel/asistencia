$(document).on('click', '.burger', function() {
  $(".burger").toggleClass("is-active")
  $(".navbar-menu").toggleClass("is-active")
});

$(document).on('change', '.check-course', function() {
  url = '/toggle-course'
  user_id = $(this).data('user-id')
  $.post( url, { user_id: user_id })
  .done(function( data ) {
      
  })
});

$(document).on('change', '.check-unlimited', function() {
  url = '/toggle-unlimited'
  user_id = $(this).data('user-id')
  $.post( url, { user_id: user_id })
  .done(function( data ) {
      
  })
});

$(document).on('change', '.check-vulnerable', function() {
  url = '/toggle-vulnerable'
  user_id = $(this).data('user-id')
  $.post( url, { user_id: user_id })
  .done(function( data ) {
      
  })
});


function get_max_employees() {
  var max_occupation = parseInt($('#max-occupation').val())
  var employees_count = parseInt($('#employees-count').val())
  return Math.floor(max_occupation / 100 * employees_count)
}

function validate_h1() {
  var max = get_max_employees()
  var checked = 0
  $('.check-h1').each(function () {
  	if (this.checked) {
      checked += 1
  	}
  });
  return checked <= max
}

function validate_h2() {
  var max = get_max_employees()
  var checked = 0
  $('.check-h2').each(function () {
  	if (this.checked) {
      checked += 1
  	}
  });
  return checked <= max
}

function enable_save(used_id) {
  $('.check-h1').attr("disabled", true)
  $('.check-h2').attr("disabled", true)
  $('.notes').attr("disabled", true)
  $('#check-h1-' + user_id).attr("disabled", false)
  $('#check-h2-' + user_id).attr("disabled", false)
  $('#notes-' + user_id).attr("disabled", false)
  $("#save-" + user_id).attr("disabled", false)	
  $("#unsaved").val("1")
}

$(document).on('change', '.check-h1', function() {
  user_id = $(this).data('user-id')
  if (!validate_h1(user_id)) {
    alert('Se excede del máximo permitido')
    $('#check-h1-' + user_id).prop('checked', false)
    return false
  }
  enable_save(user_id)
});

$(document).on('change', '.check-h2', function() {
  user_id = $(this).data('user-id')
  if (!validate_h2(user_id)) {
    alert('Se excede del máximo permitido')
    $('#check-h2-' + user_id).prop('checked', false)
    return false
  }
  enable_save(user_id)
});

$(document).on('change', '.notes', function() {
  user_id = $(this).data('user-id')
  enable_save(user_id)
});


$(document).on('click', '.save-button', function() {
  var user_id = $(this).data('user-id')
  var h1 = $('#check-h1-' + user_id).prop('checked') ? 'true' : 'false'
  var h2 = $('#check-h2-' + user_id).prop('checked') ? 'true' : 'false'
  var notes = $('#notes-' + user_id).val()
  var work_date = $('#work-date').val()

  if ((notes.length <=  0) && ((h1 == 'true') || (h2 == 'true'))) {
    alert('Necesitas especificar el motivo')
    $('#notes-' + user_id).focus()
    return false
  }


  var url = '/administrar/guardar'
  $.post( url, { user_id: user_id, 
                 work_date: work_date,
                 h1:  h1,
                 h2: h2,
                 notes: notes
               })
  .done(function( data ) {
    var department_id = $('#department-id').val()
    var work_date = $('#work-date').val()
    url = '/administrar/' + department_id + '/' + work_date
    window.location = url;
  })
});

$(document).on('click', '#create-unlimited', function() {
  var notes = $('#unlimited-notes').val()
  var work_date = $('#work-date').val()

  if (notes.length <=  0) {
    alert('Necesitas especificar el motivo')
    $('#unlimited-notes').focus()
    return false
  }


  var url = '/generar-entrada'
  $.post( url, { 
                 notes: notes
               })
  .done(function( data ) {
    url = '/'
    window.location = url;
  })
});


$(document).on('click', '.add-supervisor', function() {
  var student_id = $(this).data('student-id');
  var user_id = $('#user_id_' + student_id).val();
  var url = '/agregar-supervisor'
  $.post( url, { user_id: user_id, 
                 student_id: student_id
               })
  .done(function( data ) {
    url = '/mis-estudiantes';
    window.location = url;
  })
});

$(document).on('click', '.del-supervisor', function() {
  if (confirm('Confirmar eliminación de supervisor')) {
    var sup_id = $(this).data('sup-id');  
    var url = '/borrar-supervisor'
    $.post( url, { sup_id: sup_id
               })
    .done(function( data ) {
      url = '/mis-estudiantes';
      window.location = url;
    })
  }
});


