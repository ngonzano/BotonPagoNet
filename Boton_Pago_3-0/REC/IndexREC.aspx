<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexREC.aspx.cs" Inherits="Boton_Pago_3_0.REC.IndexREC" EnableViewStateMac="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Document</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/jquery.minicolors.css" />
    <style type="text/css">
        .precarga {
            position:fixed;
	        top:0px;
	        left:0px;
	        width:100%;
	        height:100%;
            background:transparent url(../images/ajax-loader.gif) center no-repeat;
            background-color:#F0F0F0;
            z-index:4;
	        opacity: .75;
            filter:alpha(opacity=75);
        }
    </style>
</head>
<body>
    <div id="capaCargando" style="width: 100%; height: 100%; display:none" class="precarga">
    </div>
    <div class="container-fluid">
        <h3>Integración Pago Web <span class="small">(Opción pago programado)</span></h3>
        <form id="frmIndice" method="post" action="Boton_PagoREC.aspx" target="my_frame" runat="server">

        <div class="table-responsive">
            <div id="alert_placeholder"></div>
            <table class="table">
            <tr>
                <td align="right">Código comercio</td>
                <td><div id="msgCodigocomercio"><input type="text" class="form-control input-number" id="txtCodigocomercio" value="" maxlength="9" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Moneda comercio</td>
                <td>
                    <div id="msgMonedacomercio">
                        <select class="form-control" id="cboMonedacomercio" runat="server">
                            <option value="">--Seleccione--</option>
                            <option value="PEN">PEN</option>
                            <option value="USD">USD</option>
                        </select>
                    </div>
                </td>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td align="right">Canal afiliación:</td>
                <td>
                    <select class="form-control" id="cboCanalafiliacion" runat="server">
                        <option value="web">web</option>
                        <option value="callcenter">callcenter</option>
                        <option value="recurrent">recurrent</option>
                    </select>
                </td>
                <td>&nbsp;</td>
                <td align="right">Nombre comercio:</td>
                <td><div id="msgNombrecomercio"><input type="text" class="form-control input-string" id="txtNombrecomercio" value="ONCOSALUD" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Url logo comercio:</td>
                <td><div id="msgUrllogo"><input type="text" class="form-control" id="txtUrllogo" value="http://jjdclimatizaciones.com/wp-content/uploads/2016/08/oncosalud.png" runat="server" /></div></td>
            </tr>
            <tr>
                <td align="right">Tamaño botón:</td>
                <td>
                    <div id="msgTamanhoPresentacion">
                        <select class="form-control" id="cboTamanhoPresentacion" runat="server">
                            <option value="DEFAULT">DEFAULT</option>
                            <option value="SMALL">SMALL</option>
                            <option value="MEDIUM">MEDIUM</option>
                            <option value="LARGE">LARGE</option>
                        </select>
                    </div>
                </td>
                <td>&nbsp;</td>
                <td align="right">Color botón:</td>
                <td>
                    <div id="msgColorPresentacion">
                        <select class="form-control" id="cboColorPresentacion" runat="server">
                            <option value="NAVY">AZUL</option>
                            <option value="GRAY">GRIS</option>
                        </select>
                    </div>
                </td>
                <td>&nbsp;</td>
                <td align="right">Color botón pagar:</td>
                <td><div id="msgColorboton"><input type="text" class="form-control demo" id="txtColorboton" data-control="saturation" value="#005F85" runat="server" /></div></td>
            </tr>
            <tr>
                <td align="right">Timeout (mi):</td>
                <td><div id="msgTimeout"><input type="text" class="form-control input-number" id="txtTimeout" value="20" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Url timeout:</td>
                <td><div id="msgUrltimeout"><input type="text" class="form-control" id="txtUrltimeout" value="http://apitestenv.vnforapps.com/visanet-demo/timeout.html" runat="server" /></div></td>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="8"><b>Pago Programado</b></td>
            </tr>
            <tr>
                <td align="right">Tipo:</td>
                <td>
                    <div id="msgTipo">
                    <select class="form-control" id="cboTipo" onchange="javascript:AsignaMontoInicial(this.value);" runat="server">
                        <option value="">--Seleccione--</option>
                        <option value="FIXED">Fijo</option>
                        <option value="VARIABLE">Variable</option>
                        <option value="FIXEDINITIAL">Fijo + Inicial</option>
                        <option value="VARIABLEINITIAL">Variable + Inicial</option>
                    </select>
                    </div>
                </td>
                <td>&nbsp;</td>
                <td align="right">Monto inicial:</td>
                <td><div id="msgMontoInicial"><input type="text" class="form-control input-money" id="txtMontoInicial" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Frecuencia:</td>
                <td>
                    <div id="msgFrecuencia">
                    <select class="form-control" id="cboFrecuencia" runat="server">
                        <option value="">--Seleccione--</option>
                        <option value="MONTHLY">Mensual</option>
                        <option value="QUARTERLY">Trimestral</option>
                        <option value="BIANNUAL">Semestral</option>
                        <option value="ANNUAL">Anual</option>
                    </select>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">Monto máximo:</td>
                <td><div id="msgMontoMaximo"><input type="text" class="form-control input-money" id="txtMontoMaximo" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Monto cargo:</td>
                <td><div id="msgMontoCargo"><input type="text" class="form-control input-money" id="txtMontoCargo" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Código producto:</td>
                <td><div id="msgCodigoProducto"><input type="text" class="form-control input-string" id="txtCodigoProducto" runat="server" /></div></td>
            </tr>
            <tr>
                <td align="right">Id beneficiario:</td>
                <td><div id="msgIdbeneficiario"><input type="text" class="form-control input-string" id="txtIdbeneficiario" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Tipo documento:</td>
                <td>
                    <div id="msgTipodocumento">
                    <select class="form-control" id="cboTipodocumento" runat="server">
                        <option value="">--Seleccione--</option>
                        <option value="0">DNI</option>
                        <option value="1">Canet de extranjería</option>
                        <option value="2">Pasaporte</option>
                    </select>
                    </div>
                </td>
                <td>&nbsp;</td>
                <td align="right">Número documento:</td>
                <td><div id="msgNumerodocumento"><input type="text" class="form-control input-string" id="txtNumerodocumento" runat="server" /></div></td>
            </tr>
            <tr>
                <td colspan="8">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="8">
                    <button type="button" class="btn btn-primary" onclick="javascript:CrearBoton();">Crear botón</button>
                    <button type="reset" class="btn btn-default">Limpiar</button>
                </td>
            </tr>
            </table>
        </div>

        <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Módulo de pago</h4>
                    </div>
                    <div class="modal-body">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" frameborder="0" name="my_frame" width="550" height="1200"></iframe>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        </form>
    </div>

    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/jquery.minicolors.min.js"></script>
    <script type="text/javascript">
        $('.input-number').on('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });

        $('.input-string').on('input', function () {
            this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
        });

        $('.input-money').on('keypress', function (e) {
            var field = $(this);
            key = e.keyCode ? e.keyCode : e.which;

            if (key == 8) return true;
            if (key > 47 && key < 58) {
                if (field.val() === "") return true;
                var existePto = (/[.]/).test(field.val());
                if (existePto === false) {
                    regexp = /.[0-9]{10}$/;
                }
                else {
                    regexp = /.[0-9]{2}$/;
                }

                return !(regexp.test(field.val()));
            }
            if (key == 46) {
                if (field.val() === "") return false;
                regexp = /^[0-9]+$/;
                return regexp.test(field.val());
            }
            return false;
        });

        $(function () {
            var colpick = $('.demo').each(function () {
                $(this).minicolors({
                    control: $(this).attr('data-control') || 'hue',
                    inline: $(this).attr('data-inline') === 'true',
                    letterCase: 'uppercase',
                    opacity: false,
                    change: function (hex, opacity) {
                        if (!hex) return;
                        if (opacity) hex += ', ' + opacity;
                        try {
                            console.log(hex);
                        } catch (e) { }
                        $(this).select();
                    },
                    theme: 'bootstrap'
                });
            });
        });

        bootstrap_alert = function () { }
        bootstrap_alert.danger = function (message) {
            $('#alert_placeholder').html('<div class="alert alert-danger"><a class="close" data-dismiss="alert">×</a><span>' + message + '</span></div>')
        }

        function AsignaMontoInicial(value) {
            if (value == 'FIXED' || value == 'VARIABLE') {
                $("#txtMontoInicial").val("1.00"); //1.00
                $("#txtMontoInicial").attr("readonly", "readonly");
            }
            else {
                $("#txtMontoInicial").val("");
                $("#txtMontoInicial").removeAttr("readonly");
            }

            if (value == 'VARIABLE' || value == 'VARIABLEINITIAL') {
                $("#txtMontoCargo").val("0.00");
                $("#txtMontoCargo").attr("readonly", "readonly");
            }
            else {
                $("#txtMontoCargo").val("");
                $("#txtMontoCargo").removeAttr("readonly");
            }
        }

        function CrearBoton() {
            var canal = $("#cboCanalafiliacion").val();
            var urlLogo = $("#txtUrllogo").val();
            var colorBoton = $("#txtColorboton").val();
            var timeout = $("#txtTimeout").val();
            var urlTimeout = $("#txtUrltimeout").val();
            var recurrencia = $("#cboTipo").val();
            var montoInicial = $("#txtMontoInicial").val();
            var frecuencia = $("#cboFrecuencia").val();
            var montoMaximo = $("#txtMontoMaximo").val();
            var montoCargo = $("#txtMontoCargo").val();
            var codigoProducto = $("#txtCodigoProducto").val();
            var idBeneficiario = $("#txtIdbeneficiario").val();
            var tipoDocumento = $("#cboTipodocumento").val();
            var numeroDocumento = $("#txtNumerodocumento").val();

            var codigoComercio = $("#txtCodigocomercio").val();

            if (codigoComercio == "") { $("#msgCodigocomercio").addClass('has-error'); $("#txtCodigocomercio").focus(); return; } else { $("#msgCodigocomercio").removeClass('has-error'); }

            var monedaComercio = $("#cboMonedacomercio").val();

            if (monedaComercio == "") { $("#msgMonedacomercio").addClass('has-error'); $("#txtMonedacomercio").focus(); return; } else { $("#msgMonedacomercio").removeClass('has-error'); }

            if (urlLogo == "") { $("#msgUrllogo").addClass('has-error'); $("#txtUrllogo").focus(); return; } else { $("#msgUrllogo").removeClass('has-error'); }
            if (colorBoton == "") { $("#msgColorboton").addClass('has-error'); $("#txtColorboton").focus(); return; } else { $("#msgColorboton").removeClass('has-error'); }
            if (timeout == "") { $("#msgTimeout").addClass('has-error'); $("#txtTimeout").focus(); return; } else { $("#msgTimeout").removeClass('has-error'); }
            if (urlTimeout == "") { $("#msgUrltimeout").addClass('has-error'); $("#txtUrltimeout").focus(); return; } else { $("#msgUrltimeout").removeClass('has-error'); }
            if (recurrencia == "") { $("#msgTipo").addClass('has-error'); $("#cboTipo").focus(); return; } else { $("#msgTipo").removeClass('has-error'); }
            if (montoInicial == "") { $("#msgMontoInicial").addClass('has-error'); $("#txtMontoInicial").focus(); return; } else { $("#msgMontoInicial").removeClass('has-error'); }
            if (frecuencia == "") { $("#msgFrecuencia").addClass('has-error'); $("#cboFrecuencia").focus(); return; } else { $("#msgFrecuencia").removeClass('has-error'); }
            if (montoMaximo == "") { $("#msgMontoMaximo").addClass('has-error'); $("#txtMontoMaximo").focus(); return; } else { $("#msgMontoMaximo").removeClass('has-error'); }
            if (montoCargo == "") { $("#msgMontoCargo").addClass('has-error'); $("#txtMontoCargo").focus(); return; } else { $("#msgMontoCargo").removeClass('has-error'); }
            if (codigoProducto == "") { $("#msgCodigoProducto").addClass('has-error'); $("#txtCodigoProducto").focus(); return; } else { $("#msgCodigoProducto").removeClass('has-error'); }
            if (idBeneficiario == "") { $("#msgIdbeneficiario").addClass('has-error'); $("#txtIdbeneficiario").focus(); return; } else { $("#msgIdbeneficiario").removeClass('has-error'); }
            if (tipoDocumento == "") { $("#msgTipodocumento").addClass('has-error'); $("#txtTipodocumento").focus(); return; } else { $("#msgTipodocumento").removeClass('has-error'); }
            if (numeroDocumento == "") { $("#msgNumerodocumento").addClass('has-error'); $("#txtNumerodocumento").focus(); return; } else { $("#msgNumerodocumento").removeClass('has-error'); }

            if (canal == 'recurrent' && (recurrencia == 'FIXEDINITIAL' || recurrencia == 'VARIABLEINITIAL')) {
                bootstrap_alert.danger('No existe configuración para canal <b>recurrent</b> con tipo de recurrencia <b>fija o variable + inicial</b>.');
                return;
            }

            $("#frmIndice").submit();

            document.getElementById("capaCargando").style.display = "inline";

        }

        function abrirModal() {
            document.getElementById("capaCargando").style.display = "none";
            $("#myModal").modal("toggle");
        }
    </script>
</body>
</html>
