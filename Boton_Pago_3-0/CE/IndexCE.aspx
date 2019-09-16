<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexCE.aspx.cs" Inherits="Boton_Pago_3_0.CE.IndexCE" EnableViewStateMac="false" %>

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
        <h3>Integración Pago Web <span class="small">(Opción comercio electrónico)</span></h3>
        <form id="frmIndice" method="post" action="Boton_PagoCE.aspx" target="my_frame" runat="server">

        <div class="table-responsive">
            <div id="alert_placeholder"></div>
            <table class="table">
            <tr>
                <td align="right">Código comercio:</td>
                <td><div id="msgCodigocomercio"><input type="text" class="form-control input-number" id="txtCodigocomercio" value="" maxlength="9" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Moneda comercio:</td>
                <td>
                    <div id="msgMonedacomercio">
                        <select class="form-control" id="cboMonedacomercio" runat="server">
                            <option value="">--Seleccione--</option>
                            <option value="PEN">PEN</option>
                            <option value="USD">USD</option>
                        </select>
                    </div>
                </td>
                <td>&nbsp;</td>
                <td align="right">Operación:</td>
                <td>
                    <div id="msgOperacion">
                        <select class="form-control" id="cboOperacion" runat="server">
                            <option value="true" selected="selected">CONTABLE</option>
                            <option value="false">NO CONTABLE</option>
                        </select>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">Canal afiliación:</td>
                <td>
                    <select class="form-control" id="cboCanalafiliacion" runat="server">
                        <option value="web">web</option>
                        <option value="callcenter">callcenter</option>
                        <option value="mobile">mobile</option>
                    </select>
                </td>
                <td>&nbsp;</td>
                <td align="right">Nombre comercio:</td>
                <td><div id="msgNombrecomercio"><input type="text" class="form-control input-string" id="txtNombrecomercio" value="GEEK SQUAD" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Url logo comercio:</td>
                <td><div id="msgUrllogo"><input type="text" class="form-control" id="txtUrllogo" value="data:image/jpeg;base64,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" runat="server" /></div></td>
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
                <td><div id="msgColorboton"><input type="text" class="form-control demo" id="txtColorboton" data-control="saturation" value="#000000" runat="server" /></div></td>
            </tr>
            <tr>
                <td align="right">Timeout (mi):</td>
                <td><div id="msgTimeout"><input type="text" class="form-control input-number" id="txtTimeout" value="20" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Url timeout:</td>
                <td><div id="msgUrltimeout"><input type="text" class="form-control" id="txtUrltimeout" value="http://apitestenv.vnforapps.com/visanet-demo/timeout.html" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Monto:</td>
                <td><div id="msgMontoinicial"><input type="text" class="form-control input-money" id="txtMontoinicial" runat="server" /></div></td>
            </tr>
            <tr>
                <td align="right">Nombre(s) TH:</td>
                <td><div id="msgNombreTH"><input type="text" class="form-control input-string" id="txtNombreTH" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Apellido(s) TH:</td>
                <td><div id="msgApellidoTH"><input type="text" class="form-control input-string" id="txtApellidoTH" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Email TH:</td>
                <td><div id="msgEmailTH"><input type="text" class="form-control" id="txtEmailTH" runat="server" /></div></td>
            </tr>
            <tr>
                <td align="right">Token:</td>
                <td><div id="msgToken"><input type="text" class="form-control" id="txtToken" runat="server" /></div></td>
                <td>&nbsp;</td>
                <td align="right">Mostrar monto:</td>
                <td>
                    <div id="msgMostrarmonto">
                        <select class="form-control" id="cboMostrarmonto" runat="server">
                            <option value="">--Seleccione--</option>
                            <option value="true">SI</option>
                            <option value="false">NO</option>
                        </select>
                    </div>
                </td>
                <td colspan="3">&nbsp;</td>
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
        function validarEmail(valor) {
            if (/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i.test(valor)) {
                return true;
            }
            else {
                return false;
            }
        }

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

        function CrearBoton() {

            var codigoComercio = $("#txtCodigocomercio").val();

            if (codigoComercio == "") { $("#msgCodigocomercio").addClass('has-error'); $("#txtCodigocomercio").focus(); return; } else { $("#msgCodigocomercio").removeClass('has-error'); }

            var monedaComercio = $("#cboMonedacomercio").val();

            if (monedaComercio == "") { $("#msgMonedacomercio").addClass('has-error'); $("#txtMonedacomercio").focus(); return; } else { $("#msgMonedacomercio").removeClass('has-error'); }

            var montoInicial = $("#txtMontoinicial").val();

            if (montoInicial == "") { $("#msgMontoinicial").addClass('has-error'); $("#txtMontoinicial").focus(); return; } else { $("#msgMontoinicial").removeClass('has-error'); }

            var emailTH = $("#txtEmailTH").val();

            if (emailTH != "") {
                if (!validarEmail(emailTH)) {
                    $("#msgEmailTH").addClass('has-error'); $("#txtEmailTH").focus(); return;
                }
                else {
                    $("#msgEmailTH").removeClass('has-error');
                }
            }
            else {
                $("#msgEmailTH").removeClass('has-error');
            }

            var token = $("#txtToken").val();

            if (token != "") {
                if (!validarEmail(token)) {
                    $("#msgToken").addClass('has-error'); $("#txtToken").focus(); return;
                }
                else {
                    $("#msgToken").removeClass('has-error');
                }
            }
            else {
                $("#msgToken").removeClass('has-error');
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
