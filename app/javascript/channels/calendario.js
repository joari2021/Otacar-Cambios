CALENDAR = function () { 
    
    var wrap, label,  
            months = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]; 
    function añadirFuncionTd(tr) {
        for (k=0; k<tr.length; k++){
            if (tr[k].className != "nil"){
                tr[k].setAttribute("onclick","add_date(this)")
            }
        }
        
    }

    function init(newWrap) { 
        wrap     = $(newWrap || "#cal"); 
        label    = wrap.find("#label"); 
        wrap.find("#prev").bind("click.calendar", function () { switchMonth(false); }); 
        wrap.find("#next").bind("click.calendar", function () { switchMonth(true);  }); 
        label.bind("click", function () { switchMonth(null, new Date().getMonth(), new Date().getFullYear()); });        
        label.click();
        tr = document.querySelectorAll(".curr td")
        añadirFuncionTd(tr)
    } 
 
    function switchMonth(next, month, year) { 
        var curr = label.text().trim().split(" "), calendar, tempYear =  parseInt(curr[1], 10); 
        month = month || ((next) ? ( (curr[0] === "Diciembre") ? 0 : months.indexOf(curr[0]) + 1 ) : ( (curr[0] === "Enero") ? 11 : months.indexOf(curr[0]) - 1 )); 
        year = year || ((next && month === 0) ? tempYear + 1 : (!next && month === 11) ? tempYear - 1 : tempYear);

        calendar =  createCal(year, month); 
        $("#cal-frame", wrap) 
            .find(".curr") 
                .removeClass("curr") 
                .addClass("temp") 
            .end() 
            .prepend(calendar.calendar()) 
            .find(".temp") 
                .remove();
                //.fadeOut("slow", function () { $(this).remove(); }); 
        
        $('#label').text(calendar.label);
        tr = document.querySelectorAll(".curr td")
        añadirFuncionTd(tr)
        t_body = document.getElementsByTagName("tbody")[1]
        t_body.setAttribute("id","t_body")
        $("#t_body").css({"display":"none"})
        $("#t_body").fadeIn(1000)
    } 
 
    function createCal(year, month) { 
        var day = 1, i, j, haveDays = true,  
        startDay = new Date(year, month, day).getDay(), 
        daysInMonths = [31, (((year%4==0)&&(year%100!=0))||(year%400==0)) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], 
        calendar = [];

        if (createCal.cache[year]) { 
            if (createCal.cache[year][month]) { 
                return createCal.cache[year][month]; 
            } 
        } else { 
            createCal.cache[year] = {}; 
        }

        i = 0; 
        while (haveDays) { 
            calendar[i] = []; 
            for (j = 0; j < 7; j++) { 
                if (i === 0) { 
                    if (j === startDay) { 
                        calendar[i][j] = day++; 
                        startDay++; 
                    } 
                } else if (day <= daysInMonths[month]) { 
                    calendar[i][j] = day++; 
                } else { 
                    calendar[i][j] = ""; 
                    haveDays = false; 
                } 
                if (day > daysInMonths[month]) { 
                    haveDays = false; 
                } 
            } 
            i++; 
        }
        /* ######################### CODIGO PARA SOBREPONER LOS ULTIMOS DIAS (28,29,30,31) SOBRE CUADROS DE ANTERIOR COLUMNA##########
        if (calendar[5]) { 
            for (i = 0; i < calendar[5].length; i++) { 
                if (calendar[5][i] !== "") { 
                    calendar[4][i] = "<span>" + calendar[4][i] + "</span><span>" + calendar[5][i] + "</span>"; 
                } 
            } 
            calendar = calendar.slice(0, 5); 
        }*/
        for (i = 0; i < calendar.length; i++) { 
            calendar[i] = "<tr><td>" + calendar[i].join("</td><td>") + "</td></tr>"; 
        } 
        calendar = $("<table>" + calendar.join("") + "</table>").addClass("curr"); 
         
        $("td:empty", calendar).addClass("nil"); 
        if (month === new Date().getMonth() && year === new Date().getFullYear()) { 
            $('td', calendar).filter(function () { return $(this).text() === new Date().getDate().toString(); }).addClass("today"); 
        } 
        createCal.cache[year][month] = { calendar : function () { return calendar.clone() }, label : months[month] + " " + year }; 
         
        return createCal.cache[year][month];
    } 
    createCal.cache = {}; 
    return { 
        init : init, 
        switchMonth : switchMonth, 
        createCal   : createCal 
    }; 
};