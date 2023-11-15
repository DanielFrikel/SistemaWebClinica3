//$("$txtDNI")
$("[data-mask]").inputmask();

$("#btnBuscar").on("click", function (e) {
    var dni = $("#txtDNI").val();
    //console.log(dni);
    //console.log(typeof dni);
    searchPacienteDni(dni);
    
});

function searchPacienteDni(dni) {
    var data = JSON.stringify({ dni: dni });

    $.ajax({
        type: "POST",
        url: "GestionarReservaCitas.aspx/BuscarPacienteDNI",
        data: data,
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            if (data.d == null) {
                alert('No exite el paciente con dni' + dni);
                limpiarDatosPaciente();
            } else {
                llenarDatosPaciente(data.d);
            }

        }
    });
}

function llenarDatosPaciente(obj) {
    $("#idPaciente").val(obj.IdPaciente);
    $("#txtNombres").val(obj.Nombres);
    $("#txtApellidos").val(obj.ApPaterno+" "+obj.ApMaterno);
    $("#txtTelefono").val(obj.Telefono);
    $("#txtEdad").val(obj.Edad);
    $("#txtSexo").val((obj.Sexo == 'M') ? 'Masculino' : 'Femenino');
}

function limpiarDatosPaciente() {
    $("#idPaciente").val("");
    $("#txtNombres").val("");
    $("#txtApellidos").val("");
    $("#txtTelefono").val("");
    $("#txtEdad").val("");
    $("#txtSexo").val("");
}
