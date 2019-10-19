<%@ Page Title="Logowanie" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Logowanie.aspx.cs" Inherits="DziennikASP.Logowanie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <table class="nav-justified">
    <tr>
        <td class="text-right" style="width: 46px">
            <asp:Label ID="Label1" runat="server" Text="Login: "></asp:Label>
        </td>
        <td style="width: 209px">
            <asp:TextBox ID="tbLogin" runat="server" Width="200px"></asp:TextBox>
        </td>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbLogin" ErrorMessage="Pole wymagane" ForeColor="#CC0000"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="text-right" style="width: 46px">
            <asp:Label ID="Label2" runat="server" Text="Hasło: "></asp:Label>
        </td>
        <td style="width: 209px">
            <asp:TextBox ID="tbHaslo" runat="server" Width="200px" TextMode="Password"></asp:TextBox>
        </td>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Pole wymagane" ForeColor="#CC0000" ControlToValidate="tbHaslo"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td style="width: 46px">&nbsp;</td>
        <td class="text-right" style="width: 209px">
            <asp:Button ID="Button1" runat="server" Text="Zaloguj" OnClick="Button1_Click1" />
        </td>
        <td>&nbsp;</td>
    </tr>
</table>
</asp:Content>
