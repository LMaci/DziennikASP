<%@ Page Title="Dziekanat" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pracownik.aspx.cs" Inherits="DziennikASP.Pracownik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <table class="nav-justified">
            <tr>
                <td style="width: 799px">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="20" Width="800px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="IMIE" HeaderText="IMIE" SortExpression="IMIE" />
                            <asp:BoundField DataField="NAZWISKO" HeaderText="NAZWISKO" SortExpression="NAZWISKO" />
                            <asp:BoundField DataField="PLEC" HeaderText="PLEC" SortExpression="PLEC" />
                            <asp:BoundField DataField="NUMER_ALBUMU" HeaderText="NUMER ALBUMU" SortExpression="NUMER_ALBUMU" />
                            <asp:BoundField DataField="NAZWA" HeaderText="NAZWA" SortExpression="NAZWA" >
                            <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT do.ID, do.IMIE, do.NAZWISKO, do.PLEC, st.NUMER_ALBUMU, GRUPA.NAZWA FROM DANE_OSOBOWE AS do INNER JOIN STUDENT AS st ON do.ID = st.DANE_OSOBOWE_ID INNER JOIN GRUPA ON st.GRUPA_ID = GRUPA.ID AND st.GRUPA_ID = GRUPA.ID" DeleteCommand="DELETE FROM DANE_OSOBOWE WHERE (ID = @ID)" UpdateCommand="UPDATE DANE_OSOBOWE SET IMIE = @Imie, NAZWISKO = @Nazwisko, PLEC = @Plec WHERE (ID = @ID);
">
                        <DeleteParameters>
                            <asp:Parameter Name="ID" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Imie" />
                            <asp:Parameter Name="Nazwisko" />
                            <asp:Parameter Name="Plec" />
                            <asp:Parameter Name="ID" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 799px">
                    <table class="nav-justified">
                        <tr>
                            <td style="width: 440px">
                                <asp:Panel ID="panelDodaj" runat="server" Width="260px">
                                    <table class="nav-justified">
                                        <tr>
                                            <td class="text-right" style="height: 24px">
                                                <asp:Label ID="Label1" runat="server" Text="Imie"></asp:Label>
                                            </td>
                                            <td style="height: 24px">
                                                <asp:TextBox ID="tbImie" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right" style="height: 24px">
                                                <asp:Label ID="Label2" runat="server" Text="Nazwisko"></asp:Label>
                                            </td>
                                            <td style="height: 24px">
                                                <asp:TextBox ID="tbNazwisko" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label3" runat="server" Text="Płeć"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPlec" runat="server">
                                                    <asp:ListItem>M</asp:ListItem>
                                                    <asp:ListItem>F</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label4" runat="server" Text="Nr albumu"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbIndeks" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right" style="height: 22px">
                                                <asp:Label ID="Label5" runat="server" Text="Grupa"></asp:Label>
                                            </td>
                                            <td style="height: 22px">
                                                <asp:DropDownList ID="ddlGrupa" runat="server" DataSourceID="SqlDataSource2" DataTextField="NAZWA" DataValueField="NAZWA">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT [NAZWA], [ID] FROM [GRUPA]"></asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label11" runat="server" Text="Login"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbLogin" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label12" runat="server" Text="Hasło"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbHaslo" runat="server" TextMode="Password"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">&nbsp;</td>
                                            <td>
                                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Dodaj" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                            <td>
                                <asp:Panel ID="panelModyfikuj" runat="server" Width="260px">
                                    <table class="nav-justified">
                                        <tr>
                                            <td style="height: 24px" class="text-right">
                                                <asp:Label ID="Label6" runat="server" Text="Imie"></asp:Label>
                                            </td>
                                            <td style="height: 24px">
                                                <asp:TextBox ID="tbImie0" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label7" runat="server" Text="Nazwisko"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbNazwisko0" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label8" runat="server" Text="Płeć"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPlec0" runat="server">
                                                    <asp:ListItem>M</asp:ListItem>
                                                    <asp:ListItem>F</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label9" runat="server" Text="Nr albumu"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbIndeks0" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 22px" class="text-right">
                                                <asp:Label ID="Label10" runat="server" Text="Grupa"></asp:Label>
                                            </td>
                                            <td style="height: 22px">
                                                <asp:DropDownList ID="ddlGrupa0" runat="server" datasourceid="SqlDataSource3" DataTextField="NAZWA" DataValueField="NAZWA">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT [NAZWA], [ID] FROM [GRUPA]"></asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label13" runat="server" Text="Login"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbLogin0" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">
                                                <asp:Label ID="Label15" runat="server" Text="Hasło"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbHaslo0" runat="server" TextMode="Password"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-right">&nbsp;</td>
                                            <td>
                                                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Aktualizuj" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        </table>
                </td>
            </tr>
            </table>
    </div>
</asp:Content>
