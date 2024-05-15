<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistartionForm.aspx.cs" Inherits="CurdMachineTest.RegistartionForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>FirstName</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFname"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>LastName</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtLname"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td>
                        <asp:RadioButtonList ID="rblgender" RepeatColumns="3" runat="server">
                            <%-- <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                        <asp:ListItem Text="FeMale" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Others" Value="3"></asp:ListItem>--%>
                        </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td>MobileNo</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtmobileno" TextMode="Phone"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtemail" TextMode="Email"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Country</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlcountry" AutoPostBack="true" OnSelectedIndexChanged="ddlcountry_SelectedIndexChanged">
                            <asp:ListItem Value="0">-select country-</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>State</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlstate">
                            <asp:ListItem Value="0">--select State-</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <%--<tr>
                    <td>Status</td>
                    <td><asp:CheckBox runat="server" ID="cbstatus" /></td>
                </tr>--%>
                <tr>
                    <td>
                        <asp:CheckBox ID="cbTandC" runat="server" value="0" /></td>
                    <td>I Accept Terms and condition</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" OnClientClick="return ValidationJS()" /></td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <asp:GridView runat="server" ID="grdview" OnRowCommand="grdview_RowCommand" AutoGenerateColumns="false">
                            <Columns>

                                <asp:TemplateField HeaderText="E id">
                                    <ItemTemplate>
                                        <%#Eval("eid") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="F Name">
                                    <ItemTemplate>
                                        <%#Eval("firstname") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="L Name">
                                    <ItemTemplate>
                                        <%#Eval("lastname") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Gender">
                                    <ItemTemplate>
                                        <%#Eval("gname") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Ph No">
                                    <ItemTemplate>
                                        <%#Eval("contactno") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <%#Eval("Email") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Country">
                                    <ItemTemplate>
                                        <%#Eval("cname") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="State">
                                    <ItemTemplate>
                                        <%#Eval("sname") %>
                                    </ItemTemplate>
                                </asp:TemplateField>


                               <%-- <asp:TemplateField HeaderText="T&C">
                                    <ItemTemplate>
                                        <%#Eval("TandC") %>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkedit" Text="Edit" CommandName="Cmdedit" CommandArgument='<%#Eval("eid") %>'></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="lnkdelete" Text="Delete" CommandName="CmdDelet" CommandArgument='<%#Eval("eid")%>'></asp:LinkButton>
<asp:LinkButton runat="server" ID="lnkdelete" Text="Delete" CommandName="CmdDelet" OnClientClick="return confirm('Are you sure want delete data?');" CommandArgument='<%#Eval("eid")%>'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
<script src="Scripts/jquery-3.4.1.slim.min.js"></script>
<script>
    $(document).ready(function () {
        //document.getElementById("btnsubmit").disabled = true;
    });

    //$("#cbTandC").on("change", function (event) {
    //    if (document.getElementById("cbTandC").checked) {
    //        document.getElementById("btnsubmit").disabled = false;
    //    }
    //    else {
    //        document.getElementById("btnsubmit").disabled = true;
    //    }
    //});

    function ValidationJS() {
        debugger;
        var fname = document.getElementById('<%= txtFname.ClientID %>').value.trim();
        var lname = document.getElementById('<%= txtLname.ClientID %>').value.trim();
        var mobile = document.getElementById('<%= txtmobileno.ClientID %>').value.trim();
        var email = document.getElementById('<%= txtemail.ClientID %>').value.trim();
        var country = document.getElementById('<%= ddlcountry.ClientID %>').value;
        var state = document.getElementById('<%= ddlstate.ClientID %>').value;
        var termsAccepted = document.getElementById('<%= cbTandC.ClientID %>').checked;


       

        // Validate RadioButtonList (rblgender)
        var genderSelected = false;
        var rblgender = document.getElementById('<%= rblgender.ClientID %>');
        var radioButtons = rblgender.getElementsByTagName('input');

        for (var i = 0; i < radioButtons.length; i++) {
            if (radioButtons[i].checked) {
                genderSelected = true;
                break;
            }
        }

    

        // Basic validation for other fields
        if (fname === '') {
            alert('Please enter First Name');
            return false;
        }
        if (lname === '') {
            alert('Please enter Last Name');
            return false;
        }
        if (mobile === '') {
            alert('Please enter Mobile Number');
            return false;
        }
        if (email === '') {
            alert('Please enter Email Address');
            return false;
        }
        if (country === '0') {
            alert('Please select Country');
            return false;
        }
        if (state === '0') {
            alert('Please select State');
            return false;
        }
        if (!genderSelected) {
            alert('Please select Gender');
            return false;
        }
        if (!termsAccepted) {
            alert('Please accept Terms and Conditions');
            return false;
        }
      // Additional validation rules can be added here
        return true; // Form will be submitted if all validations pass
    }

    
</script>


