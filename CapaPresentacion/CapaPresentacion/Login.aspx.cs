using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using CapaEntidades;
using CapaLogicaNegocio;
using CapaPresentacion.Custom;

namespace CapaPresentacion
{
    public partial class Login : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) 
            {
                Session["UserSession"] = null;
            }
        }

        protected void LoginUser_Authenticate(object sender, AuthenticateEventArgs e) 
        {
            bool auth = Membership.ValidateUser(LoginUser.UserName, LoginUser.Password);

            if (auth) 
            {
                Empleado objEmpleado = EmpleadoLN.getInstance().AccesoSistema(LoginUser.UserName, LoginUser.Password);

                if (objEmpleado != null)
                {
                    SessionManager = new SessionManager(Session);
                    SessionManager.UserSessionId = objEmpleado.ID.ToString();

                    //Response.Redirect("PanelGeneral.aspx");
                    FormsAuthentication.RedirectFromLoginPage(LoginUser.UserName, false);
                }
                else 
                {
                    Response.Write("<script>alert('Usuario INCORRECTO.')</script>");
                }
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {            
        }
    }
}