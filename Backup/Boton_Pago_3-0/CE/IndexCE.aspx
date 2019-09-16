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
                <td align="right">Canal afiliación:</td>
                <td>
                    <select class="form-control" id="cboCanalafiliacion" runat="server">
                        <option value="web">web</option>
                        <option value="callcenter">callcenter</option>
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
