using CapaAccesoDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaLogicaNegocio
{
    public class CitaLN
    {
        #region "PATRON SINGLETON"
        private static CitaLN citaLN = null;
        private CitaLN() { }
        public static CitaLN getInstance()
        {
            if (citaLN == null)
            {
                citaLN = new CitaLN();
            }

            return citaLN;
        }
        #endregion
        public bool RegistrarCita(Cita objCita) 
        {
			try
			{
				return CitaDAO.getInstance().RegistrarCita(objCita);
			}
			catch (Exception ex)
			{

				throw ex;
			}
        }

        public List<Cita> ListarCitas() 
        {
            try
            {
                return CitaDAO.getInstance().ListarCitas();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
