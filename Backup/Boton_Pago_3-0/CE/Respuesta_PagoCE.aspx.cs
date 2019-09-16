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

namespace Boton_Pago_3_0.CE
{
    public partial class Respuesta_PagoCE : System.Web.UI.Page
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

            string _order = (string)(context.Session["_order"]);

            DataContractJsonSerializer serOrder = new DataContractJsonSerializer(typeof(Order));
            MemoryStream msOrder = new MemoryStream(Encoding.UTF8.GetBytes(_order));
            Order _objOrder = (Order)serOrder.ReadObject(msOrder);

            Order objOrder = new Order();
            objOrder.tokenId = transactionToken;
            objOrder.purchaseNumber = _objOrder.purchaseNumber;
            objOrder.amount = _objOrder.amount;
            objOrder.currency = _objOrder.currency;

            //MerchantDefineData objMerchantDefineData = new MerchantDefineData();
            //objMerchantDefineData.MDD19 = "LIM";
            //objMerchantDefineData.MDD20 = "AQP";
            //objMerchantDefineData.MDD21 = "AFKI345";

            //Antifraud objAntifraud = new Antifraud();
            //objAntifraud.clientIp = IP4Address;
            //objAntifraud.merchantDefineData = objMerchantDefineData;

            AuthorizationRequest objAuthorizationRequest = new AuthorizationRequest();
            objAuthorizationRequest.terminalId = "1";
            objAuthorizationRequest.channel = channel;
            objAuthorizationRequest.terminalUnattended = false;
            objAuthorizationRequest.captureType = "manual";
            objAuthorizationRequest.countable = true;
            objAuthorizationRequest.order = objOrder;
            //objAuthorizationRequest.antifraud = objAntifraud;

            string body = JsonHelper.JsonSerializer<AuthorizationRequest>(objAuthorizationRequest);

            merchantId = ConfigurationManager.AppSettings["merchantId"];
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