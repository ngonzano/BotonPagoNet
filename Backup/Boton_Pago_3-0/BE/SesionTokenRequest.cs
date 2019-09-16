using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Boton_Pago_3_0.BE
{
    public class SesionTokenRequest
    {
        public string channel { get; set; }
        public double amount { get; set; }
        public double recurrenceMaxAmount { get; set; }
        public Antifraud antifraud { get; set; }
    }
}