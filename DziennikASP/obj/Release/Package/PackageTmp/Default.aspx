<%@ Page Title="Strona startowa" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DziennikASP._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Witaj na stronie głównej!</h1>
        <p class="lead">&nbsp;</p>
        <asp:LoginView ID="LoginView1" runat="server">
            <AnonymousTemplate>
                <p>Aby kontynuować musisz się zalogować.</p>
                <p></p>
                <p><a href="Logowanie.aspx" class="btn btn-primary btn-lg">Przejdź do strony logowania &raquo;</a></p>
            </AnonymousTemplate>
            <LoggedInTemplate>
                <p><a href="Secure/" class="btn btn-primary btn-lg">Przejdź do aplikacji &raquo;</a>
                </p>
            </LoggedInTemplate>

        </asp:LoginView>

    </div>

</asp:Content>
