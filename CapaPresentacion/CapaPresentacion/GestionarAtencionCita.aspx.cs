using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class GestionarAtencionCita : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                //Obtener el IdCita de la URL
                Int32 IdCita = Convert.ToInt32(Request.QueryString["idcita"]);

            }
            //Registro de la Atencion de la Cita
        }

        protected void btnRegistrar_Click(object sender, EventArgs e) 
        {

        }
    }
}