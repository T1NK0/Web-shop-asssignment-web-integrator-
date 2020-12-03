<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage_Frontend.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-lg-6">
        <h3>Kontakt</h3>
        <hr class="hr" />
        <h2>Mettes Planteskole</h2>
        <asp:Repeater ID="Repeater_Contact_Info" runat="server" DataSourceID="SqlDataSource_Contact_info">
            <ItemTemplate>
                <p><%#Eval ("contact_address") %></p>
                <p><%#Eval ("contact_postnr_by") %></p>
                <p><%#Eval ("contact_phone") %></p>
                <p><%#Eval ("contact_email") %></p>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource_Contact_info" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [contact]"></asp:SqlDataSource>

        <h2>Åbningstider</h2>
        <p id="openinghours">
            Tirsdag&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8:00 - 18:00<br />
            Fredag&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8:00 - 19:00<br />
            Lørdag&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8:00 - 16:00<br />
            Søndag&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8:00 - 13:00<br />
        </p>

        <div class="col-lg-4" style="padding: 0;">
            <asp:Label ID="Label_Name" runat="server" Text="Navn"></asp:Label>
            <asp:TextBox ID="TextBox_Name" runat="server" class="form-control"></asp:TextBox>

            <asp:Label ID="Label_Subject" runat="server" Text="Emne"></asp:Label>
            <asp:TextBox ID="TextBox_Emne" runat="server" class="form-control"></asp:TextBox>

            <asp:Label ID="Label_Email" runat="server" Text="E-mail"></asp:Label>
            <asp:TextBox ID="TextBox_Email" runat="server" class="form-control"></asp:TextBox>

            <asp:Label ID="Label_Message" runat="server" Text="Besked"></asp:Label>
            <asp:TextBox ID="TextBox_Description" Style="overflow-y: scroll; max-width: 310px; max-height: 200px; min-height: 200px; min-width: 310px;" runat="server" TextMode="MultiLine" CssClass="TextBoxDescription" class="form-control"></asp:TextBox>
            <asp:Button ID="Button_Send" runat="server" Text="Send" class="btn btn-success" /><br />
            <br />
        </div>
    </div>
</asp:Content>

