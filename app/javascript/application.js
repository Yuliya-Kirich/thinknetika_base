//= require rails-ujs
//= require bootstrap
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require("@rails/activestorage").start()
//= require channels
//= require_tree .

document.addEventListener("turbo:load", function() {
    const passwordField = document.getElementById("password_field");
    const confirmPasswordField = document.getElementById("password_confirmation_field");
    const passwordStatus = document.getElementById("password_status");

    confirmPasswordField.addEventListener("input", () => {
        if (!confirmPasswordField.value) {
            passwordStatus.style.display = 'none';
        } else if (passwordField.value === confirmPasswordField.value) {
            passwordStatus.style.display = 'block';
            passwordStatus.style.color = 'green';
            passwordStatus.textContent = 'Passwords match';
        } else {
            passwordStatus.style.display = 'block';
            passwordStatus.style.color = 'red';
            passwordStatus.textContent = 'Passwords do not match';
        }
    });
});
