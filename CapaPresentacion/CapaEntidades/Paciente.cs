using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class Paciente
    {
        public int IdPaciente { get; set; }
        public String Nombres { get; set; }
        public String ApPaterno { get; set; }
        public String ApMaterno { get; set;}
        public int Edad { get;set; }
        public char Sexo { get; set; }
        public String NroDocumento { get; set; }
        public String Direccion { get; set; }
        public String Telefono { get; set; }
        public bool Estado { get; set; }
        public String Imagen { get; set; }

        public Paciente()
        {                
        }
        //public Paciente(int idPaciente, String Nombres, String ApPaterno,
        //                String ApMaterno, int Edad, char Sexo,
        //                String NroDocumento, String Direccion,
        //                String Telefono, bool Estado, String Imagen)
        //{
            
        //}
    }
}
