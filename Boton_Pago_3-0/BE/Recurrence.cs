using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Boton_Pago_3_0.BE
{
    public class Recurrence
    {
        public string beneficiaryId { get; set; }
        public string type { get; set; }
        public string frequency { get; set; }
        public string maxAmount { get; set; }
        public string amount { get; set; }
    }
}