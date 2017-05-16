<%@ page language="C#" autoeventwireup="true" codebehind="Default.aspx.cs" inherits="Spike_WebForms_InlineScript.Default" %>
<%@ Import Namespace="System.Globalization" %>

<%@ Register tagprefix="user" namespace="Spike_WebForms_InlineScript.Controls" assembly="Spike-WebForms-InlineScript" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager runat="server" ID="SM">
                <Scripts>
                    <asp:ScriptReference Path="~/Scripts/jquery-3.1.1.min.js" />
                </Scripts>
            </asp:ScriptManager>

            <h1>Inline script</h1>

            <h2>Synchronous request</h2>
            <p>Script execution in static page.</p>
            <asp:Panel runat="server" ID="Output" CssClass="output" />
            <user:InlineScript runat="server">
                <script type="text/javascript">
                    $("#<%= this.Output.ClientID %>").html("<%= DateTime.Now.ToString(CultureInfo.InvariantCulture) %>");
                </script>
            </user:InlineScript>

            <h2>Asynchronous requests (Update panels)</h2>
            <p>Scripts in an update panel will not be executed when the panel is updated.</p>

            <asp:Button runat="server" ID="DoPostback" Text="Postback"/>

            <asp:Panel runat="server" ID="UpdatePanelOutput" CssClass="output" />
            <asp:UpdatePanel runat="server" ID="UP">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DoPostback"/>
                </Triggers>
                <ContentTemplate>
                    <script type="text/javascript">
                        var panel = $("#<%= this.UpdatePanelOutput.ClientID %>");
                        panel.html(panel.html() + "This will only be fired once in an update panel!<br />");
                    </script>                    

                    <user:InlineScript runat="server" ID="IS">
                        <script type="text/javascript">
                            var panel = $("#<%= this.UpdatePanelOutput.ClientID %>");
                            panel.html(panel.html() + "<%= DateTime.Now.ToString(CultureInfo.InvariantCulture) %><br />");
                        </script>
                    </user:InlineScript>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
