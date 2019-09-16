using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Net;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using Boton_Pago_3_0.BE;

namespace Boton_Pago_3_0.REC
{
    public partial class Respuesta_PagoREC : System.Web.UI.Page
    {
        public string endpointurl;
        public string url;
        public string merchantId;

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpContext context = HttpContext.Current;
            //string IP4Address = (string)(context.Session["IP4Address"]);
            string sesionPay = (string)(context.Session["sesionPay"]);

            string transactionToken = Request.Form["transactionToken"];
            //string customerEmail = Request.Form["customerEmail"];
            string channel = Request.Form["channel"];

            string _cardHolder = (string)(context.Session["_cardHolder"]);
            string _recurrence = (string)(context.Session["_recurrence"]);
            string _order = (string)(context.Session["_order"]);

            DataContractJsonSerializer serCardHolder = new DataContractJsonSerializer(typeof(CardHolder));
            MemoryStream msCardHolder = new MemoryStream(Encoding.UTF8.GetBytes(_cardHolder));
            CardHolder _objCardHolder = (CardHolder)serCardHolder.ReadObject(msCardHolder);

            DataContractJsonSerializer serRecurrence = new DataContractJsonSerializer(typeof(Recurrence));
            MemoryStream msRecurrence = new MemoryStream(Encoding.UTF8.GetBytes(_recurrence));
            Recurrence _objRecurrence = (Recurrence)serRecurrence.ReadObject(msRecurrence);

            DataContractJsonSerializer serOrder = new DataContractJsonSerializer(typeof(Order));
            MemoryStream msOrder = new MemoryStream(Encoding.UTF8.GetBytes(_order));
            Order _objOrder = (Order)serOrder.ReadObject(msOrder);

            Order objOrder = new Order();
            objOrder.tokenId = transactionToken;
            objOrder.productId = _objOrder.productId; //341198214 - REC VISANET
            objOrder.purchaseNumber = _objOrder.purchaseNumber;
            objOrder.amount = _objOrder.amount;
            objOrder.currency = _objOrder.currency;

            CardHolder objCardHolder = new CardHolder();
            objCardHolder.documentType = _objCardHolder.documentType; //0= DNI, 1= Canet de extranjería, 2= Pasaporte
            objCardHolder.documentNumber = _objCardHolder.documentNumber;

            Recurrence objRecurrence = new Recurrence();
            objRecurrence.beneficiaryId = _objRecurrence.beneficiaryId;
            objRecurrence.type = _objRecurrence.type;
            objRecurrence.frequency = _objRecurrence.frequency;
            objRecurrence.maxAmount = _objRecurrence.maxAmount;
            objRecurrence.amount = _objRecurrence.amount;

            AuthorizationRequest objAuthorizationRequest = new AuthorizationRequest();
            objAuthorizationRequest.channel = channel;
            objAuthorizationRequest.captureType = "manual";
            objAuthorizationRequest.countable = true;
            objAuthorizationRequest.order = objOrder;
            objAuthorizationRequest.cardHolder = objCardHolder;
            objAuthorizationRequest.recurrence = objRecurrence;

            string body = JsonHelper.JsonSerializer<AuthorizationRequest>(objAuthorizationRequest);

            merchantId = (string)(context.Session["_merchantId"]);
            endpointurl = ConfigurationManager.AppSettings["endpointurl"];
            url = "https://" + endpointurl + "/api.authorization/v3/authorization/ecommerce/" + merchantId;
            HttpWebRequest request;
            request = WebRequest.Create(url) as HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "application/json";
            request.Headers.Add("Authorization", sesionPay);
            StreamWriter writer;
            writer = new StreamWriter(request.GetRequestStream());
            writer.Write(body);
            writer.Close();

            HttpWebResponse response;
            StreamReader reader;
            string respuesta;
            try
            {
                response = request.GetResponse() as HttpWebResponse;
                reader = new StreamReader(response.GetResponseStream());
                respuesta = reader.ReadToEnd();
                reader.Close();
            }
            catch (WebException ex)
            {
                reader = new StreamReader(ex.Response.GetResponseStream(), true);
                respuesta = reader.ReadToEnd();
                reader.Close();
            }

            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(respuesta);
            Response.End();
        }
    }
}