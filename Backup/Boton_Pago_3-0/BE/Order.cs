using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Boton_Pago_3_0.BE
{
    public class Order
    {
        public string tokenId { get; set; }
        public string productId { get; set; }
        public string purchaseNumber { get; set; }
        public double amount { get; set; }
        public string currency { get; set; }
    }
}