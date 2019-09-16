using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Boton_Pago_3_0.BE
{
    public class AuthorizationRequest
    {
        //public string terminalId { get; set; }
        public string channel { get; set; }
        //public bool terminalUnattended { get; set; }
        public string captureType { get; set; }
        public bool countable { get; set; }
        public Order order { get; set; }
        public CardHolder cardHolder { get; set; }
        public Recurrence recurrence { get; set; }
        public Antifraud antifraud { get; set; }
        public Sponsored sponsored { get; set; }
    }
}