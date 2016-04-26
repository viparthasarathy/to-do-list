$(document).ready(function() {
  $('.edit').on('click', function () {
    $(this).siblings('.edit_form').toggle();
  });

  $('.add_subtask').on('click', function() {
    $(this).siblings('.add_subtask_form').toggle();
  });
});
