function address(input) {
  
  valor = input.value.toLowerCase();

  if (valor.trim() != "") {
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");

  } else if (valor.trim() != " ") {
    input.value = "";
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function validarPassword(e) {
  key = e.keyCode || e.which;

  password = document.getElementById("contraseña");
  confirmacionPassword = document.getElementById("confirmacion-contraseña");
  valor = password.value.toLowerCase();
  valorC = confirmacionPassword.value.toLowerCase();

  art1 = document.getElementById("art-1");
  art2 = document.getElementById("art-2");
  icon1 = document.getElementById("icon-1");
  icon2 = document.getElementById("icon-2");

  var longitud = false;
  var coincidencia = false;

  if (valor.length >= 8) {
    art1.classList.remove("art-invalid");
    art1.classList.add("art-valid");
    icon1.classList.remove("fa-times-circle");
    icon1.classList.add("fa-check-circle");

    longitud = true;
  }
  if (valor == valorC && valor.length > 0) {
    art2.classList.remove("art-invalid");
    art2.classList.add("art-valid");
    icon2.classList.remove("fa-times-circle");
    icon2.classList.add("fa-check-circle");

    coincidencia = true;
  } else {
    art2.classList.remove("art-valid");
    art2.classList.add("art-invalid");
    icon2.classList.remove("fa-check-circle");
    icon2.classList.add("fa-times-circle");
    coincidencia = false;
  }

  if (key == 8) {
    if (valor.length < 8) {
      art1.classList.remove("art-valid");
      art1.classList.add("art-invalid");
      icon1.classList.remove("fa-check-circle");
      icon1.classList.add("fa-times-circle");

      longitud = false;
    }
    if (valor != valorC && valor.length > 0) {
      art2.classList.remove("art-valid");
      art2.classList.add("art-invalid");
      icon2.classList.remove("fa-check-circle");
      icon2.classList.add("fa-times-circle");

      coincidencia = false;
    }
  }

  if (longitud && coincidencia) {
    password.classList.remove("is-invalid");
    password.classList.add("is-valid");
    confirmacionPassword.classList.remove("is-invalid");
    confirmacionPassword.classList.add("is-valid");
  } else {
    password.classList.remove("is-valid");
    password.classList.add("is-invalid");
    confirmacionPassword.classList.remove("is-valid");
    confirmacionPassword.classList.add("is-invalid");
  }
}

function validarCurrentPassword(e, input) {
  key = e.keyCode || e.which;

  password = input.value.toLowerCase();

  var longitud = password.length;

  if (longitud >= 8) {
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");
  }

  if (key == 8) {
    if (longitud < 8) {
      input.classList.remove("is-valid");
      input.classList.add("is-invalid");
    }
  }
}

function soloLetras(input) {
  var letras = "áéíóúabcdefghijklmnñopqrstuvwxyz";

  var newValor = "";

  for (i = 0; i < input.value.length; i++) {
    if (letras.indexOf(input.value[i].toLowerCase()) != -1) {
      newValor = newValor.concat(input.value[i].toLowerCase());
    }
  }

  if (newValor != "") {
    input.value = newValor;
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");

  } else {
    input.value = "";
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function soloNumeros(input) {
  valor = input.value.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, "");

  if (valor != "") {
    input.value = valor;
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");

    return true;
  } else {
    input.value = "";
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function validarSelect(x) {
  select = x;
  //num = y;
  coincidencia = false;

  if (select.value != "") {
    select.classList.remove("is-invalid");
    select.classList.add("is-valid");
  }
  /*
    if (num == 1) {
        valores_permit = ["soltero", "casado", "divorciado"];
    } else {
        valores_permit = ["informatica", "derecho", "administracion", "telecomunicaciones"];
    }

    for (j = 0; j < valores_permit.length; j++) {
        if (valor.value == valores_permit[j]) {
            coincicendia = true;
            values = valores_permit[j]
        }
    }
    if (coincidencia == false) {
        valor.value = values;
    } else {
        valor.value = " ";
    }
    */
}

/*
document.getElementById('email').addEventListener('input', function() {
    campo = event.target;
    //valido = document.getElementById('emailOK');

    emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
    //Se muestra un texto a modo de ejemplo, luego va a ser un icono
    if (emailRegex.test(campo.value)) {
        campo.classList.remove("is-invalid");
        campo.classList.add("is-valid");
        //valido.innerText = "válido";
    } else {
        campo.classList.remove("is-valid");
        campo.classList.add("is-invalid");
        //valido.innerText = "incorrecto";
    }
});


//VALIDACIONES


*/
