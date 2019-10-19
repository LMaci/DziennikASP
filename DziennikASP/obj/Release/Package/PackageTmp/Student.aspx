<%@ Page Title="Oceny" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="DziennikASP.Student" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div>
            <asp:Panel ID="Panel6" runat="server">
                <table class="nav-justified">
                    <tr>
                        <td class="text-left" style="height: 22px; width: 71px">
                            <asp:Label ID="Label7" runat="server" Text="Imie: "></asp:Label>
                        </td>
                        <td style="height: 22px">
                            <asp:Label ID="lbImie" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left" style="height: 22px; width: 71px">
                            <asp:Label ID="Label8" runat="server" Text="Nazwisko: "></asp:Label>
                        </td>
                        <td style="height: 22px">
                            <asp:Label ID="lbNazwisko" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left" style="width: 71px">
                            <asp:Label ID="Label9" runat="server" Text="Indeks: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbIndeks" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        <br />
        <table class="nav-justified">
            <tr>
                <td style="vertical-align:top;">
                    <asp:Panel ID="Panel5" runat="server">
                        <asp:Label ID="Label1" runat="server" Text="Przedmioty"></asp:Label>
                        <br />
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Nazwa" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="Nazwa" HeaderText="Nazwa" SortExpression="Nazwa" />
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
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="select distinct prz.Nazwa
                from
                    DANE_OSOBOWE do
                    join STUDENT st on st.DANE_OSOBOWE_ID = do.id
                    join STUDENT_PRZEDMIOT stp on stp.STUDENT_ID = st.ID
                    join PRZEDMIOT prz on prz.ID = stp.PRZEDMIOT_ID
                where 
                do.imie = @imie and do.nazwisko = @nazwisko">
                            <SelectParameters>
                                <asp:SessionParameter Name="imie" SessionField="imie" />
                                <asp:SessionParameter Name="nazwisko" SessionField="nazwisko" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                </td>
                <td style="vertical-align:top;">
                    <asp:Panel ID="Panel4" runat="server">
                        <asp:Label ID="lbOceny" runat="server" Text="Oceny"></asp:Label>
                        <br />
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="OCENA" HeaderText="OCENA" SortExpression="OCENA" />
                                <asp:BoundField DataField="OPIS" HeaderText="OPIS" SortExpression="OPIS" />
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
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT [OCENA], [OPIS] FROM [STUDENT_PRZEDMIOT] WHERE (([STUDENT_ID] = @STUDENT_ID) AND ([PRZEDMIOT_ID] = @PRZEDMIOT_ID))">
                            <SelectParameters>
                                <asp:SessionParameter Name="STUDENT_ID" SessionField="student_ID" Type="Int32" />
                                <asp:SessionParameter Name="PRZEDMIOT_ID" SessionField="przedmiot_ID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                </td>
                <td style="vertical-align:top;">
                    <asp:Panel ID="Panel3" runat="server">
                        <asp:Label ID="lbZapisanyProjekt" runat="server" Text="Projekty na które jesteś zapisany:"></asp:Label>
                        <br />
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="TEMAT" HeaderText="TEMAT" SortExpression="TEMAT" />
                                <asp:BoundField DataField="OCENA" HeaderText="OCENA" SortExpression="OCENA" >
                                <ItemStyle HorizontalAlign="Right" />
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
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT TEMAT, OCENA FROM PROJEKT WHERE (PRZEDMIOT_ID = @PRZEDMIOT_ID) AND (STUDENT_ID = @STUDENT_ID) AND (POTWIERDZONY = @POTWIERDZONY)">
                            <SelectParameters>
                                <asp:SessionParameter Name="PRZEDMIOT_ID" SessionField="przedmiot_ID" Type="Int32" />
                                <asp:SessionParameter Name="STUDENT_ID" SessionField="student_ID" Type="Int32" />
                                <asp:Parameter DefaultValue="True" Name="POTWIERDZONY" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td style="vertical-align:top;">
                    <asp:Panel ID="Panel1" runat="server">
                        <asp:Label ID="lbTrwajace" runat="server" Text="Obecnie trwające projekty:"></asp:Label>
                        <br />
                        <asp:DropDownList ID="ddlTematy" runat="server" DataSourceID="SqlDataSource4" DataTextField="TEMAT" DataValueField="TEMAT" OnSelectedIndexChanged="ddlTematy_SelectedIndexChanged">
                        </asp:DropDownList>
                        <br />
                        <asp:Button ID="btProjekt" runat="server" OnClick="btProjekt_Click" Text="Zapisz się" />
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT DISTINCT [TEMAT] FROM [PROJEKT] WHERE ([PRZEDMIOT_ID] = @PRZEDMIOT_ID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="PRZEDMIOT_ID" SessionField="przedmiot_ID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                </td>
                <td style="vertical-align:top;">
                    <asp:Panel ID="Panel2" runat="server">
                        <asp:Label ID="lbOczekujace" runat="server" Text="Oczekujące na akceptację:"></asp:Label>
                        <br />
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource5">
                            <AlternatingItemTemplate>
                                <tr style="">
                                    <td>
                                        <asp:Label ID="TEMATLabel" runat="server" Text='<%# Eval("TEMAT") %>' />
                                    </td>
                                </tr>
                            </AlternatingItemTemplate>
                            <EditItemTemplate>
                                <tr style="">
                                    <td>
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TEMATTextBox" runat="server" Text='<%# Bind("TEMAT") %>' />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <EmptyDataTemplate>
                                <table runat="server" style="">
                                    <tr>
                                        <td>No data was returned.</td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                            <InsertItemTemplate>
                                <tr style="">
                                    <td>
                                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                        <asp:Button ID="CancelButton0" runat="server" CommandName="Cancel" Text="Clear" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TEMATTextBox0" runat="server" Text='<%# Bind("TEMAT") %>' />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <tr style="">
                                    <td>
                                        <asp:Label ID="TEMATLabel0" runat="server" Text='<%# Eval("TEMAT") %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <table runat="server">
                                    <tr runat="server">
                                        <td runat="server">
                                            <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                                                <tr runat="server" style="">
                                                    <th runat="server">TEMAT</th>
                                                </tr>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" style=""></td>
                                    </tr>
                                </table>
                            </LayoutTemplate>
                            <SelectedItemTemplate>
                                <tr style="">
                                    <td>
                                        <asp:Label ID="TEMATLabel1" runat="server" Text='<%# Eval("TEMAT") %>' />
                                    </td>
                                </tr>
                            </SelectedItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT PROJEKT.TEMAT FROM PROJEKT INNER JOIN PRZEDMIOT ON PROJEKT.PRZEDMIOT_ID = PRZEDMIOT.ID WHERE (PROJEKT.STUDENT_ID = @STUDENT_ID) AND (PROJEKT.POTWIERDZONY = @POTWIERDZONY) AND (PRZEDMIOT.NAZWA = @PRZEDMIOT)">
                            <SelectParameters>
                                <asp:SessionParameter Name="STUDENT_ID" SessionField="student_ID" />
                                <asp:Parameter DefaultValue="False" Name="POTWIERDZONY" />
                                <asp:ControlParameter ControlID="GridView1" DefaultValue="" Name="PRZEDMIOT" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    </div>
        <hr />
<br />
<table class="nav-justified">
    <tr>
        <td style="width: 183px">
            <asp:Label ID="Label6" runat="server" Text="Zmiana hasła:"></asp:Label>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td style="width: 183px; height: 27px;">
            <asp:Label ID="Label4" runat="server" Text="Login"></asp:Label>
        </td>
        <td style="height: 27px">
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="width: 183px">
            <asp:Label ID="Label5" runat="server" Text="Hasło"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="width: 183px">&nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Potwierdź" />
        </td>
    </tr>
</table>
</asp:Content>
