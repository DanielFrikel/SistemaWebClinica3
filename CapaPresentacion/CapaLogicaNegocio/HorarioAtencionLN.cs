using CapaAccesoDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaLogicaNegocio
{
    public class HorarioAtencionLN
    {
        #region "PATRON SINGLETON"
        private static HorarioAtencionLN horarioAtencion = null;
        private HorarioAtencionLN() { }
        public static HorarioAtencionLN getInstance()
        {
            if (horarioAtencion == null)
            {
                horarioAtencion = new HorarioAtencionLN();
            }

            return horarioAtencion;
        }
        #endregion

        public HorarioAtencion RegistrarHorarioAtencion(HorarioAtencion objHorarioAtencion)
        {
            try
            {
                return HorarioAtencionDAO.getInstance().RegistrarHorarioAtencion(objHorarioAtencion);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public List<HorarioAtencion> Listar(Int32 idMedico)
        {
            try
            {
                return HorarioAtencionDAO.getInstance().Listar(idMedico);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public bool Eliminar(Int32 idHorarioAtencion)
        {
            try
            {
                return HorarioAtencionDAO.getInstance().Eliminar(idHorarioAtencion);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public bool Editar(HorarioAtencion objHorario)
        {

            try
            {
                return HorarioAtencionDAO.getInstance().Editar(objHorario);
            }
            catch (Exception ex)
            {

                throw ex;
            }            
        }
    }
}
