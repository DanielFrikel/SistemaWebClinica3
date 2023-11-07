function templateRow() {
    var template = "<tr>";
    template += ("<td>" + "123" + "</td>");
    template += ("<td>" + "Danielin" + "</td>");
    template += ("<td>" + "123" + "</td>");
    template += ("<td>" + "123" + "</td>");
    template += ("<td>" + "123" + "</td>");
    template += ("<td>" + "123" + "</td>");
    template += ("<td>" + "123" + "</td>");
    template += "</tr>";

    return template;
}

function addRow() {
    var template = templateRow();
    for (var i = 0; i < 10; i++){
        $("#tbl_body_table").append(template);
    }
} 

var tabla, data;

function addRowDT(data) {
    tabla = $("#tbl_pacientes").dataTable();
    for (var i = 0; i < data.length; i++) {
        tabla.fnAddData([
            data[i].IdPaciente,
            data[i].Nombres,
            (data[i].ApPaterno + " " + data[i].ApMaterno),
            ((data[i].Sexo == 'M') ? 'Masculino' : 'Femenino'),
            data[i].Edad,
            data[i].Direccion,
            '<button value="Actualizar" title="Actualizar" class="btn btn-primary btn-edit" data-target="#imodal" data-toggle="modal"><i class="fa fa-check-square-o" aria-hidden="true"></i></button>&nbsp;' +
            '<button value="Eliminar" title="Eliminar" class="btn btn-danger btn-delete"><i class="fa fa-minus-square-o" aria-hidden="true"></i></button>'
        ]);
    }
}

function sendDataAjax() {
    $.ajax({
        type: "POST",
        url: "GestionarPaciente.aspx/ListarPacientes",
        data: {},
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            //data.d
            console.log(data.d);
            addRowDT(data.d);
        }
    });
}

function updateDataAjax() {

    var obj = JSON.stringify({ id: JSON.stringify(data[0]), direccion: $("#txtModalDireccion").val() });

    $.ajax({
        type: "POST",
        url: "GestionarPaciente.aspx/ActualizarDatosPaciente",
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (response) {
            if (response.d) {
                //alert("Registro actualizado de manera CORRECTA.");

                tabla.fnClearTable();
                sendDataAjax();

            } else{
                alert("No se pudo actualizar el registro.");
            }
        }
    });
}


function deleteDataAjax(data) {

    var obj = JSON.stringify({ id: JSON.stringify(data) });

    $.ajax({
        type: "POST",
        url: "GestionarPaciente.aspx/EliminarDatosPaciente",
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (response) {
            if (response.d) {
                //alert("Registro actualizado de manera CORRECTA.");

                //tabla.fnClearTable();
                //sendDataAjax();

            } else {
                alert("No se pudo actualizar el registro.");
            }
        }
    });
}

//evento click para boton actualizar
$(document).on('click', '.btn-edit', function (e) {
    e.preventDefault();

    var row = $(this).parent().parent()[0];
    data = tabla.fnGetData(row);

    fillModalData();

});

//evento click para boton eliminar
$(document).on('click', '.btn-delete', function (e) {
    e.preventDefault();

    //Primer Metodo: Eliminar la fila del dataTable:
    var row = $(this).parent().parent()[0];
    var dataRow = tabla.fnGetData(row);        

    //Segundo Metodo: Enviar el codigo del paciente al servidor y actualizar tabla, renderizar
    //Paso 1: Enviar el id al servidor por medio de ajax
    deleteDataAjax(dataRow[0]);
    //Paso 2: Renderizar el dataTable
    sendDataAjax();
});

//Cargar datos en el modal
function fillModalData() {
    //Concatena el valor de data1 y data2 y lo ingresa en la
    //caja de texto con el id txtFullName
    $("#txtFullName").val(data[1] + " " + data[2]);

    $("#txtModalDireccion").val(data[5]);
}

//Enviar la informacion al servidor.
$("#btnActualizar").click(function (e) {
    e.preventDefault();
    updateDataAjax();

});

//Llamando a la funcion de ajax al cargar el documento
sendDataAjax();