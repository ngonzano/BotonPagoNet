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
    public partial class Boton_PagoREC : System.Web.UI.Page
    {
        public string sessionToken;
        public string channel;
        public string merchantId;
        public string buttonSize;
        public string buttonColor;
        public string merchantLogo;
        public string merchantName;
        public string formButtonColor;
        public string purchasenumber;
        public string amount;
        public string recurrence;
        public string recurrencetype;
        public string recurrencefrequency;
        public string recurrencemaxamount;
        public string recurrenceamount;
        public string expirationminutes;
        public string timeouturl;

        public string endpointurl;
        public string url;
        public double amountPay;
        public double recurrentMaxAmountPay;
        public string user;
        public string password;
        public string credentials;

        public static string GetIP4Address()
        {
            string url = "http://bot.whatismyipaddress.com/";
            string result = null;

            try
            {
                WebClient client = new WebClient();
                result = client.DownloadString(url);
                return result;
            }
            catch (Exception ex) { return "127.0.0.1"; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            merchantId = ConfigurationManager.AppSettings["merchantId"];
            endpointurl = ConfigurationManager.AppSettings["endpointurl"];
            user = ConfigurationManager.AppSettings["user"];
            password = ConfigurationManager.AppSettings["password"];
            credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(user + ":" + password));
            amountPay = Convert.ToDouble(Request.Form["txtMontoInicial"]);
            recurrentMaxAmountPay = Convert.ToDouble(Request.Form["txtMontoMaximo"]);

            ServicePointManager.Expect100Continue = true;
            ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
            ServicePointManager.DefaultConnectionLimit = 9999;

            url = "https://" + endpointurl + "/api.security/v1/security";

            HttpWebRequest request;
            request = WebRequest.Create(url) as HttpWebRequest;
            request.Method = "POST";
            request.Headers.Add("Authorization", "Basic " + credentials);
            StreamWriter writer;
            writer = new StreamWriter(request.GetRequestStream());
            writer.Close();

            HttpWebResponse response;
            StreamReader reader;
            string respuesta;
            try
            {
                response = request.GetResponse() as HttpWebResponse;
                reader = new StreamReader(response.GetResponseStream());
                respuesta = reader.ReadToEnd();
                Session["sesionPay"] = respuesta;
                reader.Close();

                MerchantDefineData objMerchantDefineData = new MerchantDefineData();
                objMerchantDefineData.MDD19 = "LIM";
                objMerchantDefineData.MDD20 = "AQP";
                objMerchantDefineData.MDD21 = "AFKI345";

                Antifraud objAntifraud = new Antifraud();
                string IP4Address = GetIP4Address();
                Session["IP4Address"] = IP4Address;
                objAntifraud.clientIp = IP4Address;
                objAntifraud.merchantDefineData = objMerchantDefineData;

                SesionTokenRequest objSesionTokenRequest = new SesionTokenRequest();
                objSesionTokenRequest.channel = Request.Form["cboCanalafiliacion"];
                objSesionTokenRequest.amount = amountPay;
                objSesionTokenRequest.recurrenceMaxAmount = recurrentMaxAmountPay;
                objSesionTokenRequest.antifraud = objAntifraud;

                string body = JsonHelper.JsonSerializer<SesionTokenRequest>(objSesionTokenRequest);

                url = "https://" + endpointurl + "/api.ecommerce/v2/ecommerce/token/session/" + merchantId;
                request = WebRequest.Create(url) as HttpWebRequest;
                request.Method = "POST";
                request.ContentType = "application/json";
                request.Headers.Add("Authorization", respuesta);
                writer = new StreamWriter(request.GetRequestStream());
                writer.Write(body);
                writer.Close();

                string resultado;
                try
                {
                    response = request.GetResponse() as HttpWebResponse;
                    reader = new StreamReader(response.GetResponseStream());
                    var buffer = reader.ReadToEnd();
                    resultado = buffer.ToString();
                    reader.Close();

                    DataContractJsonSerializer service = new DataContractJsonSerializer(typeof(SesionTokenResponse));
                    MemoryStream memory = new MemoryStream(Encoding.UTF8.GetBytes(resultado));
                    SesionTokenResponse objResultado = (SesionTokenResponse)service.ReadObject(memory);

                    /*Llenado de variables del botón*/
                    sessionToken = objResultado.sessionKey;
                    channel = Request.Form["cboCanalafiliacion"];
                    buttonSize = Request.Form["cboTamanhoPresentacion"];
                    buttonColor = Request.Form["cboColorPresentacion"];
                    merchantLogo = Request.Form["txtUrllogo"];
                    merchantName = Request.Form["txtNombrecomercio"];
                    formButtonColor = Request.Form["txtColorboton"];
                    Random random = new Random();
                    purchasenumber = random.Next(1000, 9999).ToString();
                    amount = amountPay.ToString();
                    recurrence = "TRUE";
                    recurrencetype = Request.Form["cboTipo"];
                    recurrencefrequency = Request.Form["cboFrecuencia"];
                    recurrencemaxamount = recurrentMaxAmountPay.ToString();
                    recurrenceamount = Request.Form["txtMontoCargo"];
                    expirationminutes = Request.Form["txtTimeout"];
                    timeouturl = Request.Form["txtUrltimeout"];
                    /*Fin de llenado de variables del botón*/

                    CardHolder objCardHolder = new CardHolder();
                    objCardHolder.documentType = Request.Form["cboTipodocumento"];
                    objCardHolder.documentNumber = Request.Form["txtNumerodocumento"];

                    string _cardHolder = JsonHelper.JsonSerializer<CardHolder>(objCardHolder);
                    Session["_cardHolder"] = _cardHolder;

                    Recurrence objRecurrence = new Recurrence();
                    objRecurrence.beneficiaryId = Request.Form["txtIdbeneficiario"];
                    objRecurrence.type = Request.Form["cboTipo"];
                    objRecurrence.frequency = Request.Form["cboFrecuencia"];
                    objRecurrence.maxAmount = recurrentMaxAmountPay.ToString();
                    objRecurrence.amount = Request.Form["txtMontoCargo"];

                    string _recurrence = JsonHelper.JsonSerializer<Recurrence>(objRecurrence);
                    Session["_recurrence"] = _recurrence;

                    Order objOrder = new Order();
                    objOrder.productId = Request.Form["txtCodigoProducto"];
                    objOrder.purchaseNumber = purchasenumber;
                    objOrder.amount = amountPay;
                    objOrder.currency = ConfigurationManager.AppSettings["moneda"];

                    string _order = JsonHelper.JsonSerializer<Order>(objOrder);
                    Session["_order"] = _order;
                }
                catch (WebException ex)
                {
                    resultado = ex.Message.ToString();
                }

            }
            catch (WebException ex)
            {
                respuesta = ex.Message.ToString();
            }
        }
    }
}