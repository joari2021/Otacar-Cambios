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
  newValor = "";
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

function soloNumeros(input, min, max) {
  valor = input.value.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, "");

  input.value = valor;
  if (valor.length >= min && valor.length <= max) {
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");
  } else {
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function formatDocumentoVzla(input) {
  valor = input.value.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, "");

  var numericaInt = parseInt(valor);

  if (numericaInt <= 80000000){
    type_document = "V-"
    input.value = type_document.concat(valor);
  }else if(numericaInt > 80000000){
    type_document = "E-"
    input.value = type_document.concat(valor);
  }else{
    input.value = "";
  }

  if (valor.length > 5 && valor.length < 9 ) {
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");
  } else {
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function formatNumberPhoneVzla(input) {
  valor = input.value.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, "");
  codArea = "0414 0424 0416 0426 0412";
  num = valor.slice(0,4);
  codigo = false;
  if (codArea.indexOf(num) != -1){
    codigo = true;
  }
  if (valor.length === 11 && codigo === true ) {
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");
  } else {
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function validarSelect(x) {
  select = x;

  if (select.value != "" && select.value != undefined) {
    select.classList.remove("is-invalid");
    select.classList.add("is-valid");
  }else {
    select.classList.remove("is-valid");
    select.classList.add("is-invalid");
  }
}

function validarEmail(input) {
  campo = input.value;
  //valido = document.getElementById('emailOK');

  emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
  //Se muestra un texto a modo de ejemplo, luego va a ser un icono
  if (emailRegex.test(campo)) {
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");
    //valido.innerText = "válido";
  } else {
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
    //valido.innerText = "incorrecto";
  }
}

function inputCPF(input) {
  valor = input.value.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1-$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");

  input.value = valor;
  if (valor.length === 14) {
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");
  } else {
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function monto(input) {
        
  valor = input.value.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1,$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
  
  if (valor.length === 1){
      input.value = "0,0".concat(valor);
  }else if(valor.length === 2){
      if (valor === "00"){
          input.value= "0,00";
      }else{
          input.value = "0,".concat(valor);
      }
      
  }else if(valor.length === 4){
      
      input.value = valor;
      
  }else if(valor.length === 5){
      if (valor[0] === "0") {
          input.value= valor.slice(1);
      }else{
          input.value= valor;
      }
      
  }else{           
      limit = valor.length 
      for (i=0; i < limit; i++){
          if(valor[0] === "0" || valor[0] === "."){
              valor = valor.slice(1);
          }else{
              break;
          }  
      }   
      input.value = valor;
  }              
}

function validarUsuario(input) {

  var re = / /g;
  var resultado = input.value.replace(re, "");

  if (resultado != "") {
    input.value = resultado
    input.classList.remove("is-invalid");
    input.classList.add("is-valid");
  } else {
    input.value = "";
    input.classList.remove("is-valid");
    input.classList.add("is-invalid");
  }
}

function verifyBank(select){
  campo_identidy = document.getElementById("validationCPF")
  label_cp = document.getElementById("label-cp")
  div_cp = document.getElementById("div-cp")
  if (select.value === "Santander"){
    campo_identidy.removeAttribute("oninput")
    campo_identidy.setAttribute("oninput","habilitarSave(),inputCPNJ(this)")

    label_cp.innerHTML = "Nro CPNJ *"
    div_cp.innerHTML = "Ingrese un CPNJ válido"
    
  }else{
    campo_identidy.removeAttribute("oninput")
    campo_identidy.setAttribute("oninput","habilitarSave(),inputCPF(this)")

    label_cp.innerHTML = "Nro CPF *"
    div_cp.innerHTML = "Ingrese un CPF válido"
  }
  campo_identidy.value = ""
  campo_identidy.classList.remove("is-valid")
  campo_identidy.classList.add("is-invalid")
}

function inputCPNJ(input){
  valor = input.value.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, "");

  if (valor.length === 14){
    aux = valor.slice(0,12)
    valor2 = aux.replace(/\D/g, "");
    valor2 = valor2.replace(/([0-9])([0-9]{4})$/, "$1/$2");
    valor2 = valor2.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
    valor3 = valor2 + "-" + valor.slice(12)
    valor4 = valor3.slice(0,12) + valor3.slice(13)
    input.value = valor4
    input.classList.remove("is-invalid")
    input.classList.add("is-valid")

  }else{
    input.value = valor
    input.classList.remove("is-valid")
    input.classList.add("is-invalid")
  }
}
//VALIDACIONES