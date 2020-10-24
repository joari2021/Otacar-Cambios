/*
--------------------------------
Ajax Contact Form
--------------------------------
+ https://github.com/mehedidb/Ajax_Contact_Form
+ A Simple Ajax Contact Form developed in PHP with HTML5 Form validation.
+ Has a fallback in jQuery for browsers that do not support HTML5 form validation.
+ version 1.0.1
+ Copyright 2016 Mehedi Hasan Nahid
+ Licensed under the MIT license
+ https://github.com/mehedidb/Ajax_Contact_Form
*/

(function ($, window, document, undefined) {
  "use strict";

  var $form = $("#contact-form");
  var btnEnviar = $("#btnEnviar");

  var namePattern = "^[a-z A-Z ñ]{4,30}$";
  var emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$";

  function checkInput(idInput, pattern) {
    return $(idInput).val().match(pattern) ? true : false;
  }

  function checkTextarea(idText) {
    return $(idText).val().length > 9 ? true : false;
  }

  function enableSubmit(idForm) {
    $(idForm + " input.submit").removeAttr("disabled");
  }

  function disableSubmit(idForm) {
    $(idForm + " input.submit").attr("disabled", "disabled");
  }

  function checkForm(idForm) {
    $(idForm + " *").on("change keydown", function () {
      if (
        checkInput("#form-name", namePattern) &&
        checkInput("#form-email", emailPattern) &&
        checkInput("#form-phone", namePattern) &&
        checkTextarea("#form-message")
      ) {
        enableSubmit(idForm);
        $(".form-group").removeClass("has-error");
        $(".help-block").remove();
      } else {

        disableSubmit(idForm);

        if (!checkInput("#form-name", namePattern)) {
          $("#name-field").removeClass("has-error");
          $("#name-field .help-block").remove();

          $("#name-field").addClass("has-error");
          $("#name-field")
            .find(".form-input")
            .append(
              '<span class="help-block">' +
                "Ingrese solo letras en el campo nombre. (Caracteres Min: 4; Max: 30)" +
                "</span>"
            );
        }else{
          $("#name-field").removeClass("has-error");
          $("#name-field .help-block").remove();
        }

        if (!checkInput("#form-email", emailPattern)) {
          $("#email-field").removeClass("has-error");
          $("#email-field .help-block").remove();

          $("#email-field").addClass("has-error");
          $("#email-field")
            .find(".form-input")
            .append(
              '<span class="help-block">' +
                "Ingrese un correo valido" +
                "</span>"
            );
        }else{
          $("#email-field").removeClass("has-error");
          $("#email-field .help-block").remove();
        }

        if (!checkInput("#form-phone", namePattern)) {
          $("#phone-field").removeClass("has-error");
          $("#phone-field .help-block").remove();

          $("#phone-field").addClass("has-error");
          $("#phone-field")
            .find(".form-input")
            .append(
              '<span class="help-block">' +
                "Ingrese solo letras en el campo Asunto. (Caracteres Min: 4; Max: 30)" +
                "</span>"
            );
        }else{
          $("#phone-field").removeClass("has-error");
          $("#phone-field .help-block").remove();
        }

        if (!checkTextarea("#form-message") ) {
          $("#message-field").removeClass("has-error");
          $("#message-field .help-block").remove();

          $("#message-field").addClass("has-error");
          $("#message-field")
            .find(".form-input")
            .append(
              '<span class="help-block">' +
                "(Caracteres Min: 10)" +
                "</span>"
            );
        }else{
          $("#message-field").removeClass("has-error");
          $("#message-field .help-block").remove();
        }
      }
    });
  }

  $(function () {
    checkForm("#contact-form");
  });

  $form.submit(function (e) {
    // remove the error class
    $(".form-group").removeClass("has-error");
    $(".help-block").remove();

    // get the form data
    var mensajes = {
      mensajes: {
        nombre: $('input[name="form-name"]').val(),
        email: $('input[name="form-email"]').val(),
        asunto: $('input[name="form-phone"]').val(),
        mensaje: $('textarea[name="form-message"]').val(),
      },
    };

    // process the form
    $.ajax({
      type: "POST",
      url: "/mensaje/create",
      data: mensajes,
      dataType: "json",
      encode: true,
      beforeSend: function () {
        btnEnviar.val("Enviando");
        btnEnviar.attr("disabled", "disabled");
      },
      complete: function (data) {
        btnEnviar.val("Enviar Mensaje");
        btnEnviar.removeAttr("disabled");
      },
      success: function (data) {
        $form.html(
          '<div class="alert alert-success">' +
            "Mensaje Enviado con Exito" +
            "</div>"
        );
      },
      error: function (data) {
        $("#fracaso").delay(500).fadeIn("slow");

        //Arreglar resaltado de inputs con error
        /*
        if (data.errors.name) {
          
        }

        if (data.errors.email) {
          $("#email-field").addClass("has-error");
          $("#email-field")
            .find(".form-input")
            .append(
              '<span class="help-block">' + data.errors.email + "</span>"
            );
        }

        if (data.errors.asunto) {
          $("#phone-field").addClass("has-error");
          $("#phone-field")
            .find(".form-input")
            .append(
              '<span class="help-block">' + data.errors.asunto + "</span>"
            );
        }

        if (data.errors.mensaje) {
          $("#message-field").addClass("has-error");
          $("#message-field")
            .find(".form-input")
            .append(
              '<span class="help-block">' + data.errors.mensaje + "</span>"
            );
        }
        */
      },
    });
    /*
    if(success === true) {
            // handle errors
            
              
            
            };
          
                if (data.errors.name) {
                    $('#name-field').addClass('has-error');
                    $('#name-field').find('.form-input').append('<span class="help-block">' + data.errors.name + '</span>');
                }

                if (data.errors.email) {
                    $('#email-field').addClass('has-error');
                    $('#email-field').find('.form-input').append('<span class="help-block">' + data.errors.email + '</span>');
                }

                if (data.errors.phone) {
                    $('#phone-field').addClass('has-error');
                    $('#phone-field').find('.form-input').append('<span class="help-block">' + data.errors.phone + '</span>');
                }

                if (data.errors.message) {
                    $('#message-field').addClass('has-error');
                    $('#message-field').find('.form-input').append('<span class="help-block">' + data.errors.message + '</span>');
                }
            } else {
                // display success message
                $form.html('<div class="alert alert-success">' + data.message + '</div>');
            }
        }).fail(function (data) {
            // for debug
            console.log(data)
        });*/

    e.preventDefault();
  });
})(jQuery, window, document);
