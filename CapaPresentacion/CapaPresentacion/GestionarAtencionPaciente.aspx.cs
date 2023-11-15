using CapaEntidades;
using CapaLogicaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class GestionarAtencionPaciente : System.Web.UI.Page
    {
        private static String COMMAND_REGISTER = "Registrar";
        private static String COMMAND_CANCEL = "Cancelar";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                llenarDataList();
                lblFechaAtencion.Text = DateTime.Now.ToShortDateString();
            }
        }

        private void llenarDataList() 
        {
            List<Cita> ListaCitas = CitaLN.getInstance().ListarCitas();
            dlAtencionMedica.DataSource = ListaCitas;
            dlAtencionMedica.DataBind();
        }

        protected void dlAtencionMedica_ItemCommand(object source, DataListCommandEventArgs e) 
        {
            if (e.CommandName == COMMAND_REGISTER)
            {

                //Realizar el Registro de la Atencion                
                //Redireccion a la pagina de GestionarAtencionCita.aspx                
                String IdCita = (e.Item.FindControl("hdIdCita") as HiddenField).Value;
                //Enviar IdCita a la URL y redirecciona.
                Response.Redirect("GestionarAtencionCita.aspx?idcita="+IdCita);
            }
            else if(e.CommandName == COMMAND_CANCEL)
            {
                //Realizar la Cancelacion de la Reservacion

            }
        }
    }
}