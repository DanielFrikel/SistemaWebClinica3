using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class HorarioAtencion
    {
        public int idHorarioAtencion { get; set; }
        public Medico medico { get; set; }
        public Hora horaCita { get; set; }
        public DateTime Fecha { get; set; }
        public bool Estado { get; set; }

        public HorarioAtencion()
        {
            
        }

    }
}
