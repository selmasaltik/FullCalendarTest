using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FullCalendarWebApp
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class FcItem
        {
            public string id;
            public string title;
            public string start;
            public string end;
            public string msg;
        }


        [WebMethod]
        public static List<FcItem> Get(int bgun, int bay, int byil, int egun, int eay, int eyil)
        {
            DateTime bDate = new DateTime(byil, bay, bgun);
            DateTime eDate = new DateTime(eyil, eay, egun);

            List<FcItem> list = new List<FcItem>();
            for (int i = 0; bDate < eDate; i++)
            {
                FcItem fcItem = new FcItem();
                fcItem.id = i.ToString();
                fcItem.start = bDate.ToString("yyyy-MM-dd 12:00:00");
                fcItem.end = bDate.ToString("yyyy-MM-dd 14:00:00");
                fcItem.msg = bDate.ToString("dd.MM.yyyy ") + " tarihindeki " + fcItem.id + " numaralı olaya tıkladınız!";
                fcItem.title = "item" + i;

                list.Add(fcItem);

                bDate = bDate.AddDays(1);
            }

            return list;
        }
    }
}