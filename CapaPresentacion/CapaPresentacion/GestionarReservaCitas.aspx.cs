using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using CapaLogicaNegocio;

namespace CapaPresentacion
{
    public partial class GestionarReservaCitas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                grdHorariosAtencion.DataSource = LlenarGridView();
                grdHorariosAtencion.DataBind();

                LlenarEspecialidades();
            }
        }

        private void LlenarEspecialidades() 
        {
            List<Especialidad> Lista = EspecialidadLN.getInstance().Listar();

            ddlEspecialidad.DataSource = Lista;
            ddlEspecialidad.DataValueField = "IdEspecialidad";
            ddlEspecialidad.DataTextField = "Descripcion";
            ddlEspecialidad.DataBind();
        }

        private List<ClaseTest> LlenarGridView() 
        {
            List<ClaseTest> Lista = new List<ClaseTest>();
            Lista.Add(new ClaseTest { Hora = "10:00", Medico = "Daniel Aguilar" });
            Lista.Add(new ClaseTest { Hora = "13:00", Medico = "Jose Lopez" });
            Lista.Add(new ClaseTest { Hora = "15:30", Medico = "Felipe Hernandez" });

            return Lista;
        }

        [WebMethod]
        public static Paciente BuscarPacienteDNI(String dni)
        {
            return PacienteLN.getInstance().BuscarPacienteDNI(dni);
        }

        protected void btnBuscarHorario_Click(object sender, EventArgs e)
        {

        }

        protected void btnReservarCita_Click(object sender, EventArgs e)
        {

        }

        //Solo para hacer pruebas
        public class ClaseTest 
        {
            public string Hora { get; set; }
            public string Medico { get; set; }
        }
    }
}