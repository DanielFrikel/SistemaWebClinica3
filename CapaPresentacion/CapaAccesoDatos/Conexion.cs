using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAccesoDatos
{
    public class Conexion
    {
        #region "PATRON SINGLETON"
        private static Conexion conexion = null;
        private Conexion() { }
        public static Conexion getInstance()
        {
            if (conexion == null) 
            {
                conexion = new Conexion();
            }

            return conexion;
        }

        #endregion

        public SqlConnection ConexionDB()
        {
            SqlConnection conexion = new SqlConnection();
            conexion.ConnectionString = "Data Source=localhost; Initial Catalog=DBClinica_test1; User ID=sa; password=123Tamarindo;";
           
            return conexion;
        }


    }
}
