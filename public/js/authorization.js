$(document).ready(function() {
  bindSignUp();
  bindLogIn();
});

function bindLogIn(){
  $('.login').on('click', function() {
    $('h1').text('Login');
    $('button').text('Login');
    $('form').attr('action', '/login');
  });
}

function bindSignUp(){
  $('.signup').on('click', function() {
    $('h1').text('Sign Up');
    $('button').text('Sign Up');
    $('form').attr('action', '/signup');
  });
}
