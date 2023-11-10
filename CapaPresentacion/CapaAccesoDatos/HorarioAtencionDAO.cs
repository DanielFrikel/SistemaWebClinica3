using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Text;
using System.Threading.Tasks;
using CapaEntidades;

namespace CapaAccesoDatos
{
    public class HorarioAtencionDAO
    {
        #region "PATRON SINGLETON"
        private static HorarioAtencionDAO daoHorarioAtencion = null;
        private HorarioAtencionDAO() { }
        public static HorarioAtencionDAO getInstance()
        {
            if (daoHorarioAtencion == null)
            {
                daoHorarioAtencion = new HorarioAtencionDAO();
            }
            return daoHorarioAtencion;
        }
        #endregion

        public HorarioAtencion RegistrarHorarioAtencion(HorarioAtencion objHorarioAtencion) 
        {

            SqlConnection conexion = Conexion.getInstance().ConexionDB();
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            HorarioAtencion objHorario = null;

            try
            {
                cmd = new SqlCommand("spRegistrarHorarioAtencion",conexion);
                cmd.Parameters.AddWithValue("@prmIdMedico",objHorarioAtencion.medico.IdMedico);
                cmd.Parameters.AddWithValue("@prmHora", objHorarioAtencion.horaCita.hora);
                cmd.Parameters.AddWithValue("@prmFecha", objHorarioAtencion.Fecha);
                cmd.CommandType = CommandType.StoredProcedure;

                conexion.Open();

                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    //Generar el objeto de HorarioAtencion
                    //HA.idHorarioAtencion, HA.fecha, H.idHora, H.hora, HA.estado
                    objHorario = new HorarioAtencion()
                    {
                        idHorarioAtencion = Convert.ToInt32(dr["idHorarioAtencion"].ToString()),
                        Fecha = Convert.ToDateTime(dr["fecha"].ToString()),
                        horaCita = new Hora()
                        {
                            IdHora = Convert.ToInt32(dr["idHora"].ToString()),
                            hora = dr["hora"].ToString()
                        },
                        Estado = Convert.ToBoolean(dr["estado"].ToString())                        
                    };
                }                
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally 
            {
                conexion.Close();
            }
            return objHorario;
        }

        public List<HorarioAtencion> Listar(Int32 idMedico)
        {
            SqlConnection conexion = Conexion.getInstance().ConexionDB();
            SqlCommand cmd = null;
            SqlDataReader dr = null;
            List<HorarioAtencion> Lista = null;

            try
            {
                cmd = new SqlCommand("spListaHorariosAtencion", conexion);
                cmd.Parameters.AddWithValue("@prmIdMedico", idMedico);
                cmd.CommandType = CommandType.StoredProcedure;

                conexion.Open();

                dr = cmd.ExecuteReader();

                Lista = new List<HorarioAtencion>();

                while (dr.Read())
                {
                    // llenamos los objetos
                    HorarioAtencion objHorario = new HorarioAtencion();
                    objHorario.idHorarioAtencion = Convert.ToInt32(dr["idHorarioAtencion"].ToString());
                    objHorario.Fecha = Convert.ToDateTime(dr["fecha"].ToString());
                    objHorario.horaCita = new Hora()
                    {
                        hora = dr["hora"].ToString()
                    };

                    Lista.Add(objHorario);
                }
            } 
            catch (Exception ex)
            {
                throw ex;
            }
            finally 
            {
                conexion.Close();
            }

            return Lista;

        }

        public bool Eliminar(Int32 idHorarioAtencion)
        {

            bool ok = false;

            SqlConnection conexion = null;
            SqlCommand cmd = null;

            try
            {
                conexion = Conexion.getInstance().ConexionDB();
                cmd = new SqlCommand("spEliminarHorarioAtencion", conexion);
                cmd.Parameters.AddWithValue("@prmIdHorarioAtencion", idHorarioAtencion);
                cmd.CommandType = CommandType.StoredProcedure;

                conexion.Open();

                cmd.ExecuteNonQuery();

                ok = true;
            }
            catch (Exception ex)
            {
                ok = false;
                throw ex;
            }
            finally
            {
                conexion.Close();
            }

            return ok;
        }
    }
}
