using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entity.Securities
{
    public class SecuritiesStatusChart
    {
        // close: 90.5257
        // high: 90.6657
        // low: 85.7685
        // open: 85.9757
        // volume: 660187068
        // x: Mon Apr 02 2012 05:30:00 GMT+0530 (India Standard Time)

        public DateTime x { get; set; }
        public decimal open { get; set; }
        public decimal high { get; set; }
        public decimal low { get; set; }
        public decimal close { get; set; }
        public decimal volume { get; set; }
    }
}
