function inputNumber(event) {

    $(event.target).val(function(index, value) {
        
        if (value.length === 0) {
            return "0,00";
        }
        if (value.length === 5) {
            let num = "0123456789";

            if (num.indexOf(value[4]) == -1 && value[3] == "0") {
                return valor = "0,00";
            } else if (num.indexOf(value[4]) == -1 && value[3] != "0" && value[0] == "0") {
                let str1 = "0"
                let str2 = value.slice(1, 4);
                return str1.concat(str2);
            }
        }
        if (value == "0,0") {
            return valor = "0,00";
        } else if (value.length === 3 && value[0] === "0") {
            let complemento1 = value[2];
            valor = "0,0";
            return valor.concat(complemento1);
        } else if (value.length === 3 && value[0] != "0" && value[2] != "0") {
            let str11 = "0,"
            let str12 = value.replace(",", "");
            return str11.concat(str12);
        } else if (value.length === 3 && value[0] != "0" && value[2] == "0") {
            let string1 = "0,"
            let string2 = value.replace(",", "");
            return string1.concat(string2);
        }
        valor = value.replace(/\D/g, "")
        valor = valor.replace(/([0-9])([0-9]{2})$/, '$1,$2')
        valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");

        if (valor[0] == "0" && valor[1] == "0") {
            let str22 = valor.slice(1);
            return str22;
        } else if (valor[0] == "0" && valor[1] != "0") {
            let str23 = valor.slice(1);
            return str23;
        }

        return valor;

    });

}