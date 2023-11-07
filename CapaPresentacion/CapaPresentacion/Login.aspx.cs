using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CapaEntidades;
using CapaLogicaNegocio;

namespace CapaPresentacion
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            String usuario = txtUsuario.Text;
            String pass = txtPassword.Text;

            Empleado objEmpleado = EmpleadoLN.getInstance().AccesoSistema(usuario,pass);

            if (objEmpleado != null) 
            {
                Response.Write("<script>alert('USUARIO CORRECTO.') </script>");
                Response.Redirect("PanelGeneral.aspx");
            }
            else
            {
                Response.Write("<script>alert('USUARIO INCORRECTO.') </script>");
            }

        }
    }
}