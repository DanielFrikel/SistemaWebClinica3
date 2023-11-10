
//Configuracion de timepicker y date
$("[data-mask]").inputmask();
$(".timepicker").timepicker({ showInputs: false, showMeridian: false, minuteStep: 30 });

var tabla;

$("#btnBuscar").on("click", function (event) {
    event.preventDefault();

    //Obtener los datos del texto de Dni    
    var dni = $("#txtDni").val();    
    var obj = JSON.stringify({ dni: dni });        

    if (dni.length > 0) {
        //Llamada a AJAX
        $.ajax({
            type: "POST",
            url: "GestionarHorarioAtencion.aspx/BuscarMedico",
            data: obj,
            contentType: 'application/json; charset=utf-8',
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
            },
            success: function (data) {                
                console.log("Exito", data.d);                
                llenarDatosMedico(data.d);
            }
        });
    } else {
        console.log("No ha ingresado un Dni.");
    }    

});

function llenarDatosMedico(obj) {
    $("#lblNombres").text(obj.Nombres);
    $("#lblApellidos").text(obj.ApPaterno.concat(" ".concat(obj.ApMaterno)));
    $("#lblEspecialidad").text(obj.Especialidad.Descripcion);
    $("#txtMedico").val(obj.IdMedico);
}

//Agregar un horario
$("#btnAgregar").on('click', function (e) {
    e.preventDefault();

    //Obtener los valores de los campos
    var fecha, hora, idmedico;
    fecha = $("#txtFecha").val();
    hora = $("#txtHoraInicio").val();
    idmedico = $("#txtMedico").val(); 

    if (fecha.length > 0 && hora.length > 0 && idmedico > 0) {
        var obj = JSON.stringify({ fecha: fecha, hora: hora, idmedico: idmedico });

        $.ajax({
            type: "POST",
            url: "GestionarHorarioAtencion.aspx/AgregarHorario",
            data: obj,
            contentType: 'application/json; charset=utf-8',
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
            },
            success: function (data) {
                console.log("Exito", data);
                //Cerrar ventana modal usano jquery
                $("#AgregarHorario").modal('toggle');   
                addRowDT(data.d);                
                console.log("momentjs", moment(data.d.Fecha).toDate());
            }
        });

    } else {
        console.log("Ingrese los datos requeridos.");
    }
});


$("#btnAgregarHorario").on('click', function (e) {
    e.preventDefault(); 
});

$("#btnGuardarHorario").on('click', function (e) {
    e.preventDefault();

});

function initDataTable(){
    tabla = $("#tbl_horarios").dataTable({
        "aaSorting": [[0, 'desc']],
        "bSort": true,
        "aoColumns": [
            { "bSortable": false }, //No permite ordenamiento   
            { "bSortable": false },
            null,
            null
        ]
    });
}

initDataTable();

function addRowDT(obj) {
    tabla.fnClearTable();

    //YA NO SE USA EL .ToDate()
    var fecha = moment(obj.Fecha).format("DD/MM/YYYY");
    console.log(fecha);

    tabla.fnAddData([
        '<button value="Actualizar" title="Actualizar" class="btn btn-primary btn-edit" data-target="#imodal" data-toggle="modal"><i class="fa fa-check-square-o" aria-hidden="true"></i></button>',
        '<button value="Eliminar" title="Eliminar" class="btn btn-danger btn-delete"><i class="fa fa-minus-square-o" aria-hidden="true"></i></button>',
        fecha,
        obj.horaCita.hora
    ]);

}

//fecha.format is not a function
function formatDate(date) {
    console.log(date);
    var fecha = date.replace('/Date(', '');
    fecha = fecha.replace(')/', '');
    fecha = new Date(parseInt(fecha));
    
}