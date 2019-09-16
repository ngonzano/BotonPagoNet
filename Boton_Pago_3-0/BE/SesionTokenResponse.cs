using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Boton_Pago_3_0.BE
{
    public class SesionTokenResponse
    {
        public string sessionKey { get; set; }
        public string expirationTime { get; set; }
    }
}