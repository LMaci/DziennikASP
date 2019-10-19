<%@ Page Title="Oceny i projekty" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wykladowca.aspx.cs" Inherits="DziennikASP.Wykladowca" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <table class="nav-justified">
        <tr>
            <td style="vertical-align:top;", "width: 300px">
                <asp:Label ID="Label4" runat="server" Text="Wybierz przedmiot:"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="NAZWA" HeaderText="NAZWA" SortExpression="NAZWA" />
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
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT [NAZWA] FROM [PRZEDMIOT] WHERE ([PRACOWNIK_ID] = @PRACOWNIK_ID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="PRACOWNIK_ID" SessionField="pracownik_ID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
            <td style="vertical-align:top;">
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" DataKeyNames="ID">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="IMIE" HeaderText="IMIE" SortExpression="IMIE" />
                                <asp:BoundField DataField="NAZWISKO" HeaderText="NAZWISKO" SortExpression="NAZWISKO" />
                                <asp:BoundField DataField="NUMER_ALBUMU" HeaderText="NUMER_ALBUMU" SortExpression="NUMER_ALBUMU" />
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
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT DISTINCT do.IMIE, do.NAZWISKO, st.NUMER_ALBUMU, st.ID FROM DANE_OSOBOWE AS do INNER JOIN STUDENT AS st ON st.DANE_OSOBOWE_ID = do.ID INNER JOIN STUDENT_PRZEDMIOT AS stp ON stp.STUDENT_ID = st.ID INNER JOIN PRZEDMIOT AS prz ON prz.ID = stp.PRZEDMIOT_ID WHERE (prz.ID = @przedmiot_ID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="przedmiot_ID" SessionField="przedmiot_ID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
            <td style="vertical-align:top;">
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                <asp:BoundField DataField="OPIS" HeaderText="OPIS" SortExpression="OPIS" />
                                <asp:BoundField DataField="OCENA" HeaderText="OCENA" SortExpression="OCENA" />
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
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" DeleteCommand="DELETE FROM [STUDENT_PRZEDMIOT] WHERE [ID] = @original_ID AND (([OPIS] = @original_OPIS) OR ([OPIS] IS NULL AND @original_OPIS IS NULL)) AND (([OCENA] = @original_OCENA) OR ([OCENA] IS NULL AND @original_OCENA IS NULL))" InsertCommand="INSERT INTO [STUDENT_PRZEDMIOT] ([OPIS], [OCENA]) VALUES (@OPIS, @OCENA)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [OPIS], [OCENA], [ID] FROM [STUDENT_PRZEDMIOT] WHERE (([PRZEDMIOT_ID] = @PRZEDMIOT_ID) AND ([STUDENT_ID] = @STUDENT_ID))" UpdateCommand="UPDATE [STUDENT_PRZEDMIOT] SET [OPIS] = @OPIS, [OCENA] = @OCENA WHERE [ID] = @original_ID AND (([OPIS] = @original_OPIS) OR ([OPIS] IS NULL AND @original_OPIS IS NULL)) AND (([OCENA] = @original_OCENA) OR ([OCENA] IS NULL AND @original_OCENA IS NULL))">
                            <DeleteParameters>
                                <asp:Parameter Name="original_ID" Type="Int32" />
                                <asp:Parameter Name="original_OPIS" Type="String" />
                                <asp:Parameter Name="original_OCENA" Type="Decimal" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="OPIS" Type="String" />
                                <asp:Parameter Name="OCENA" Type="Decimal" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:SessionParameter Name="PRZEDMIOT_ID" SessionField="przedmiot_ID" Type="Int32" />
                                <asp:SessionParameter Name="STUDENT_ID" SessionField="student_ID" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="OPIS" Type="String" />
                                <asp:Parameter Name="OCENA" Type="Decimal" />
                                <asp:Parameter Name="original_ID" Type="Int32" />
                                <asp:Parameter Name="original_OPIS" Type="String" />
                                <asp:Parameter Name="original_OCENA" Type="Decimal" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
        </tr>
        <tr>
            <td style="width: 300px">
                <asp:Button ID="Button3" runat="server" Text="Powrót do poprzedniej strony" />
            </td>
            <td>&nbsp;</td>
            <td>
                        <asp:Panel ID="Panel1" runat="server" Height="95px" Width="267px">
                            Dodaj nową ocenę:<table class="auto-style1">
                                <tr>
                                    <td class="auto-style4">
                                        <asp:Label ID="Label1" runat="server" Text="Ocena:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList1" runat="server">
                                            <asp:ListItem>2</asp:ListItem>
                                            <asp:ListItem>2,5</asp:ListItem>
                                            <asp:ListItem>3</asp:ListItem>
                                            <asp:ListItem Value="3,5">3,5</asp:ListItem>
                                            <asp:ListItem Value="4"></asp:ListItem>
                                            <asp:ListItem>4,5</asp:ListItem>
                                            <asp:ListItem>5</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style4">
                                        <asp:Label ID="Label2" runat="server" Text="Opis:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbOpis" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style4">&nbsp;</td>
                                    <td class="auto-style5">
                                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Dodaj" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
        </tr>
    </table>
    </asp:Content>
