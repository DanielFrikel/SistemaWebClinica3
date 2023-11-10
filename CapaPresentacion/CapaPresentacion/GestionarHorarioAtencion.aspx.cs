using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using CapaEntidades;
using CapaLogicaNegocio;
using CapaPresentacion.Custom;

namespace CapaPresentacion
{
    public partial class GestionarHorarioAtencion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static Medico BuscarMedico(String dni)
        {
            return MedicoLN.getInstance().BuscarMedico(dni);
        }

        [WebMethod]
        public static HorarioAtencion AgregarHorario(String fecha, String hora, String idmedico) 
        {
            //System.FormatException: 'String was not recognized as a valid DateTime.'
            string dateString = fecha;

            // Definir el formato de la fecha
            string format = "dd/MM/yyyy";

            // Convertir el string en un objeto DateTime usando el formato especificado
            DateTime dateTime = DateTime.ParseExact(dateString, format, System.Globalization.CultureInfo.InvariantCulture);

            HorarioAtencion objHorarioAtencion = new HorarioAtencion()
            {
                Fecha = dateTime,
                horaCita = new Hora() 
                {
                    hora = hora
                },                
                medico = new Medico()
                {
                    IdMedico = Convert.ToInt32(idmedico)
                }
            };

            return HorarioAtencionLN.getInstance().RegistrarHorarioAtencion(objHorarioAtencion);
        }
    }
}