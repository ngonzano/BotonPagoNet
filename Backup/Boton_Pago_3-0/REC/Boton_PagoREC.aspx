<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Boton_PagoREC.aspx.cs" Inherits="Boton_Pago_3_0.REC.Boton_PagoREC" EnableViewStateMac="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
    <div align="center">
        <form id="formBoton" action="Respuesta_PagoREC.aspx" method="post" runat="server">
        <script type="text/javascript" id="javascriptBoton" src='https://static-origin.vnforapps.com/v2/js/checkout.js?qa=true' 
            data-sessiontoken='<%=sessionToken%>'
		    data-channel='<%=channel%>'

            data-merchantid='<%=merchantId%>'
            data-buttonsize='<%=buttonSize%>'
            data-buttoncolor='<%=buttonColor%>'
            data-merchantlogo='<%=merchantLogo%>'
            data-merchantname='<%=merchantName%>'
		    data-formbuttoncolor='<%=formButtonColor%>'

		    data-purchasenumber='<%=purchasenumber%>'
            data-amount='<%=amount%>'

		    data-recurrence='<%=recurrence%>'
            data-recurrencetype='<%=recurrencetype%>'
            data-recurrencefrequency='<%=recurrencefrequency%>'
            data-recurrencemaxamount='<%=recurrencemaxamount%>'
            data-recurrenceamount='<%=recurrenceamount%>'

            data-expirationminutes='<%=expirationminutes%>'
            data-timeouturl='<%=timeouturl%>'

        ></script>
        </form>
    </div>
</body>
</html>
<script type="text/javascript">
    window.parent.abrirModal();
</script>
