//$("$txtDNI")

$("#btnBuscar").on("click", function (e) {
    e.preventDefault();

    var dni = $("#txtDNI").val();
    //console.log(dni);
    //console.log(typeof dni);
    searchPacienteDni(dni);
    
});

function searchPacienteDni(dni) {
    var obj = JSON.stringify({ dni: dni });
    console.log(obj);

    $.ajax({
        type: "POST",
        url: "GestionarReservaCitas.aspx/BuscarPacienteDNI",
        data: obj,
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {                   
            if (data.d == null) {
                alert('No existe el paciente con dni: ' + dni);
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
    $("#idPaciente").val("0");
    $("#txtNombres").val("");
    $("#txtApellidos").val("");
    $("#txtTelefono").val("");
    $("#txtEdad").val("");
    $("#txtSexo").val("");
}