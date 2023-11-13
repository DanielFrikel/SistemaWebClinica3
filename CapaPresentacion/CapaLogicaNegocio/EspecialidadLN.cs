using CapaAccesoDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaLogicaNegocio
{
    public class EspecialidadLN
    {
        #region "PATRON SINGLETON"
        private static EspecialidadLN objEspecialidad = null;
        private EspecialidadLN() { }
        public static EspecialidadLN getInstance()
        {
            if (objEspecialidad == null)
            {
                objEspecialidad = new EspecialidadLN();
            }

            return objEspecialidad;
        }
        #endregion


        public List<Especialidad> Listar() 
        {
            return EspecialidadDAO.getInstance().Listar();
        }

    }
}
