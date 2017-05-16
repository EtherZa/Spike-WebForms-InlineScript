namespace Spike_WebForms_InlineScript.Controls
{
    using System.IO;
    using System.Text;
    using System.Web.UI;

    public class InlineScript : Control
    {
        protected override void Render(HtmlTextWriter writer)
        {
            var sm = ScriptManager.GetCurrent(this.Page);
            if (sm != null && sm.IsInAsyncPostBack)
            {
                var sb = new StringBuilder();
                base.Render(new HtmlTextWriter(new StringWriter(sb)));
                var script = sb.ToString();

                ScriptManager.RegisterStartupScript(this, typeof(InlineScript), this.UniqueID, script, false);
            }
            else
            {
                base.Render(writer);
            }
        }
    }
}