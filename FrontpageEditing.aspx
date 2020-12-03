<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="FrontpageEditing.aspx.cs" Inherits="FrontpageEditing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-lg-10" style="float: right;">
        <asp:TextBox ID="TextBoxTitle" runat="server" placeholder="Titel"></asp:TextBox><br />
        <asp:TextBox ID="TextBoxDescription" Style="overflow-y: scroll; max-width: 750px; max-height: 200px; min-height: 200px; min-width: 750px;" runat="server" TextMode="MultiLine" placeholder="Beskrivelse"></asp:TextBox><br />
        <asp:TextBox ID="TextBoxOpeningHours" Style="overflow-y: scroll; max-width: 750px; max-height: 200px; min-height: 200px; min-width: 750px;" runat="server" TextMode="MultiLine" placeholder="Åbningstider"></asp:TextBox><br />
        <asp:TextBox ID="TextBoxOpeningChanges" runat="server" placeholder="Åbningstids Ændringer"></asp:TextBox><br />
        <asp:TextBox ID="TextBoxContactInfo" Style="overflow-y: scroll; max-width: 750px; max-height: 200px; min-height: 200px; min-width: 750px;" runat="server" TextMode="MultiLine" placeholder="Kontakt information"></asp:TextBox><br />
        <asp:FileUpload ID="FileUploadImage" runat="server" />
        <asp:HiddenField ID="HiddenFieldGem" runat="server" />
        <asp:Image ID="Image1" runat="server" visible="false"/>
        <asp:Button ID="ButtonUpload" runat="server" Text="Upload" OnClick="ButtonUpload_Click" />
        <asp:Button ID="ButtonGem" runat="server" Text="Gem" OnClick="ButtonGem_Click" Visible="false"/>
    </div>

    <div class="col-lg-10" style="float: right;">
        <hr />
        <table class="table">
            <thead>
                <tr>
                    <th class="col-lg-2">Overskrift</th>
                    <th class="col-lg-4">Beskrivelse</th>
                    <th class="col-lg-2">Billede</th>
                    <th class="col-lg-2">Ret</th>
                    <th class="col-lg-2">Slet</th>
                </tr>
            </thead>
        </table>
        <asp:Repeater ID="RepeaterFrontpageTexts" runat="server" DataSourceID="SqlDataSourceFrontpageTexts" OnItemCommand="RepeaterFrontpageTexts_ItemCommand">
            <ItemTemplate>
                <table class="table table-hover">
                    <tr>
                        <td class="col-lg-2"><%#Eval ("page_headings") %></td>
                        <td class="col-lg-4"><%#Eval ("page_text") %></td>
                        <td>
                            <asp:HiddenField ID="HiddenField_img_slet1" runat="server" Value='<%#Eval ("page_images") %>' />
                            <img class="col-lg-2" src="images/frontpage/<%#Eval ("page_images") %>" style="width:100%; height:auto;"/></td>
                        <td class="col-lg-2">
                            <asp:LinkButton ID="LinkButton_ret" class="btn btn-success" runat="server" CommandArgument='<%#Eval ("page_id") %>' CommandName="Ret"><i class="fa fa-pencil" aria-hidden="true"></i></asp:LinkButton></td>
                        <td class="col-lg-2">
                            <asp:LinkButton ID="LinkButton_slet" class="btn btn-danger" runat="server" CommandArgument='<%#Eval ("page_id") %>' CommandName="Slet"><i class="fa fa-trash-o" aria-hidden="true"></i></asp:LinkButton></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSourceFrontpageTexts" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [pages]"></asp:SqlDataSource>
    </div>
</asp:Content>

