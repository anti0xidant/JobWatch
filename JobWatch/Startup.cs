using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(JobWatch.Startup))]
namespace JobWatch
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
