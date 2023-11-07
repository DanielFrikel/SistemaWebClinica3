<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CapaPresentacion.Login" %>

<!DOCTYPE html>

<html class="bg-black" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <title>Acceso al Sistema de Clinica</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="css/AdminLTE.css" rel="stylesheet" type="text/css"/> 

</head>
<body class="bg-black">
    <form id="form1" runat="server">
        <div class="form-box" id="login-box">
            <asp:Login ID="LoginUser" runat="server" EnableViewState="false" OnAuthenticate="LoginUser_Authenticate" Width="100%">
                <LayoutTemplate>
                    <div class="header">Login</div>
                    <div class="body bg-gray">
                    <div class="form-group">
                        <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="Ingrese Usuario"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Ingrese Contraseña" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="footer">
                        <asp:Button ID="btnIngresar" CommandName="Login" runat="server" Text="Iniciar Sesion" CssClass="btn bg-olive btn-block" OnClick="btnIngresar_Click" />
                    </div>
                </LayoutTemplate>
            </asp:Login>            
        </div>
    </form>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" type="text/javascript"></script>
</body>

</html>
