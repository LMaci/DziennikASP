<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projekty.aspx.cs" Inherits="DziennikASP.Projekty" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <table class="nav-justified">
        <tr>
            <td style="vertical-align:top; width: 344px;", "width: 300px">
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
            <td style="width: 400px">
                <asp:Panel ID="Panel2" runat="server">
                    <asp:Label ID="Label5" runat="server" Text="Wybierz projekt: "></asp:Label>
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="TEMAT" HeaderText="TEMAT" SortExpression="TEMAT" />
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
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" DeleteCommand="DELETE FROM PROJEKT WHERE (TEMAT = @original_TEMAT)" InsertCommand="INSERT INTO [PROJEKT] ([TEMAT], [STUDENT_ID], [PRACOWNIK_ID], [PRZEDMIOT_ID], [OCENA], [POTWIERDZONY]) VALUES (@TEMAT, @STUDENT_ID, @PRACOWNIK_ID, @PRZEDMIOT_ID, @OCENA, @POTWIERDZONY)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM (SELECT ID, TEMAT, PRZEDMIOT_ID, Row_number() OVER (PARTITION BY Temat,PRZEDMIOT_ID ORDER BY ID) rn FROM Projekt) t WHERE (rn = 1 AND przedmiot_id = @przedmiot)" UpdateCommand="UPDATE PROJEKT SET TEMAT = @TEMAT WHERE (TEMAT = @original_TEMAT) OR (TEMAT IS NULL) AND (@original_TEMAT IS NULL)">
                        <DeleteParameters>
                            <asp:Parameter Name="original_TEMAT" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="TEMAT" Type="String" />
                            <asp:Parameter Name="STUDENT_ID" Type="Int32" />
                            <asp:Parameter Name="PRACOWNIK_ID" Type="Int32" />
                            <asp:Parameter Name="PRZEDMIOT_ID" Type="Int32" />
                            <asp:Parameter Name="OCENA" Type="Int32" />
                            <asp:Parameter Name="POTWIERDZONY" Type="Boolean" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:SessionParameter Name="przedmiot" SessionField="przedmiot_id" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="TEMAT" Type="String" />
                            <asp:Parameter Name="original_TEMAT" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
            </td>
            <td style="vertical-align:top;">
                <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None" DataKeyNames="ID">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="IMIE" HeaderText="IMIE" SortExpression="IMIE" />
                            <asp:BoundField DataField="NAZWISKO" HeaderText="NAZWISKO" SortExpression="NAZWISKO" />
                            <asp:BoundField DataField="NUMER_ALBUMU" HeaderText="NUMER ALBUMU" SortExpression="NUMER_ALBUMU" />
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
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" DeleteCommand="DELETE FROM PROJEKT FROM PROJEKT INNER JOIN STUDENT ON PROJEKT.STUDENT_ID = STUDENT.ID INNER JOIN DANE_OSOBOWE ON STUDENT.DANE_OSOBOWE_ID = DANE_OSOBOWE.ID WHERE (DANE_OSOBOWE.IMIE = @original_IMIE) AND (DANE_OSOBOWE.NAZWISKO = @original_NAZWISKO) AND (STUDENT.NUMER_ALBUMU = @original_NUMER_ALBUMU) AND (PROJEKT.OCENA = @original_OCENA) OR (DANE_OSOBOWE.IMIE = @original_IMIE) AND (DANE_OSOBOWE.NAZWISKO = @original_NAZWISKO) AND (STUDENT.NUMER_ALBUMU = @original_NUMER_ALBUMU) AND (PROJEKT.OCENA IS NULL)" SelectCommand="SELECT PROJEKT.ID AS Expr1, PROJEKT.TEMAT, PROJEKT.STUDENT_ID, PROJEKT.PRACOWNIK_ID, PROJEKT.PRZEDMIOT_ID, PROJEKT.OCENA, PROJEKT.POTWIERDZONY, STUDENT.ID, STUDENT.DANE_OSOBOWE_ID, STUDENT.GRUPA_ID, STUDENT.NUMER_ALBUMU, DANE_OSOBOWE.ID AS Expr2, DANE_OSOBOWE.IMIE, DANE_OSOBOWE.NAZWISKO, DANE_OSOBOWE.PLEC, DANE_OSOBOWE.AUTH_ID FROM PROJEKT INNER JOIN STUDENT ON PROJEKT.STUDENT_ID = STUDENT.ID INNER JOIN DANE_OSOBOWE ON STUDENT.DANE_OSOBOWE_ID = DANE_OSOBOWE.ID WHERE (PROJEKT.TEMAT = @Temat) AND (PROJEKT.POTWIERDZONY = 1)" UpdateCommand="UPDATE PROJEKT SET OCENA = @Ocena FROM PROJEKT INNER JOIN STUDENT ON PROJEKT.STUDENT_ID = STUDENT.ID INNER JOIN DANE_OSOBOWE ON STUDENT.DANE_OSOBOWE_ID = DANE_OSOBOWE.ID WHERE (PROJEKT.OCENA = @original_OCENA) AND (DANE_OSOBOWE.IMIE = @original_IMIE) AND (DANE_OSOBOWE.NAZWISKO = @original_NAZWISKO) AND (STUDENT.NUMER_ALBUMU = @original_NUMER_ALBUMU) AND (PROJEKT.TEMAT = @original_TEMAT) OR (PROJEKT.OCENA IS NULL) AND (DANE_OSOBOWE.IMIE = @original_IMIE) AND (DANE_OSOBOWE.NAZWISKO = @original_NAZWISKO) AND (STUDENT.NUMER_ALBUMU = @original_NUMER_ALBUMU) AND (PROJEKT.TEMAT = @original_TEMAT)" ConflictDetection="CompareAllValues" InsertCommand="INSERT INTO [PROJEKT] ([TEMAT], [STUDENT_ID], [PRACOWNIK_ID], [PRZEDMIOT_ID], [OCENA], [POTWIERDZONY]) VALUES (@TEMAT, @STUDENT_ID, @PRACOWNIK_ID, @PRZEDMIOT_ID, @OCENA, @POTWIERDZONY)" OldValuesParameterFormatString="original_{0}">
                        <DeleteParameters>
                            <asp:Parameter Name="original_IMIE" Type="String" />
                            <asp:Parameter Name="original_NAZWISKO" Type="String" />
                            <asp:Parameter Name="original_NUMER_ALBUMU" Type="String" />
                            <asp:Parameter Name="original_OCENA" Type="Decimal" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="TEMAT" Type="String" />
                            <asp:Parameter Name="STUDENT_ID" Type="Int32" />
                            <asp:Parameter Name="PRACOWNIK_ID" Type="Int32" />
                            <asp:Parameter Name="PRZEDMIOT_ID" Type="Int32" />
                            <asp:Parameter Name="OCENA" Type="Int32" />
                            <asp:Parameter Name="POTWIERDZONY" Type="Boolean" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lbTemat" Name="Temat" PropertyName="Text" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Ocena" Type="Decimal" />
                            <asp:Parameter Name="original_OCENA" Type="Double" />
                            <asp:Parameter Name="original_IMIE" Type="String" />
                            <asp:Parameter Name="original_NAZWISKO" Type="String" />
                            <asp:Parameter Name="original_NUMER_ALBUMU" Type="String" />
                            <asp:ControlParameter ControlID="lbTemat" Name="original_TEMAT" PropertyName="Text" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:Label ID="lbTemat" runat="server" Text="Temat" Visible="False"></asp:Label>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td style="width: 344px">&nbsp;</td>
            <td style="width: 400px">
                <br />
                <asp:Panel ID="panelNowyTemat" runat="server" Visible="False">
                    <asp:Label ID="Label6" runat="server" Text="Dodaj nowy projekt:"></asp:Label>
                    <br />
                    <table class="nav-justified" style="width: 59%">
                        <tr>
                            <td style="width: 53px">
                                <asp:Label ID="Label7" runat="server" Text="Nazwa: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tbTemat" runat="server" Width="258px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 53px">&nbsp;</td>
                            <td class="text-right">
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Dodaj" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <br />
                <br />
                <br />
            </td>
            <td>
                <asp:Panel ID="Panel3" runat="server" Visible="False">
                    <table class="nav-justified">
                        <tr>
                            <td style="width: 246px; height: 22px">
                                <asp:Label ID="Label8" runat="server" Text="Oczekujące na akceptację: "></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 246px">
                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView4_SelectedIndexChanged">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True" />
                                        <asp:BoundField DataField="IMIE" HeaderText="IMIE" SortExpression="IMIE" />
                                        <asp:BoundField DataField="NAZWISKO" HeaderText="NAZWISKO" SortExpression="NAZWISKO" />
                                        <asp:BoundField DataField="NUMER_ALBUMU" HeaderText="NUMER_ALBUMU" SortExpression="NUMER_ALBUMU" />
                                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
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
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DziennikConnectionString %>" SelectCommand="SELECT DANE_OSOBOWE.IMIE, DANE_OSOBOWE.NAZWISKO, STUDENT.NUMER_ALBUMU, PROJEKT.ID FROM DANE_OSOBOWE INNER JOIN STUDENT ON DANE_OSOBOWE.ID = STUDENT.DANE_OSOBOWE_ID INNER JOIN PROJEKT ON STUDENT.ID = PROJEKT.STUDENT_ID WHERE (PROJEKT.TEMAT = @Temat) AND (PROJEKT.POTWIERDZONY = 0) OR (PROJEKT.TEMAT = @Temat) AND (PROJEKT.POTWIERDZONY IS NULL)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lbTemat" Name="Temat" PropertyName="Text" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 246px">
                                <table class="nav-justified" style="width: 118%">
                                    <tr>
                                        <td class="text-right" style="width: 71px">
                                            <asp:Label ID="Label9" runat="server" Text="Imie: "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbImie" runat="server" Text="-"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-right" style="width: 71px; height: 22px">
                                            <asp:Label ID="Label10" runat="server" Text="Nazwisko: "></asp:Label>
                                        </td>
                                        <td style="height: 22px">
                                            <asp:Label ID="lbNazwisko" runat="server" Text="-"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-right" style="width: 71px">
                                            <asp:Label ID="Label11" runat="server" Text="Indeks: "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbIndeks" runat="server" Text="-"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-right" style="width: 71px">&nbsp;</td>
                                        <td>
                                            <table class="nav-justified">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="Button6" runat="server" OnClick="Button2_Click" Text="Akceptuj" />
                                                    </td>
                                                    <td class="text-right">
                                                        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Odrzuć" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td style="width: 344px">&nbsp;</td>
            <td style="width: 400px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
