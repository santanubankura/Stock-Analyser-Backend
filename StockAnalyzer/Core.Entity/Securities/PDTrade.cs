using System;
using System.Collections.Generic;

namespace Core.Entity.Securities
{
    public class PDTrade
    {
        public Int64 Id { get; set; }
        public Security SecurityInfo { get; set; }
        public string TRADING_DATE { get; set; }
        public decimal PREV_CL_PR { get; set; }
        public decimal OPEN_PRICE { get; set; }
        public decimal HIGH_PRICE { get; set; }
        public decimal LOW_PRICE { get; set; }
        public decimal CLOSE_PRICE { get; set; }
        public decimal NET_TRDVAL { get; set; }
        public decimal NET_TRDQTY { get; set; }
        public string IND_SEC { get; set; }
        public string CORP_IND { get; set; }
        public decimal TRADES { get; set; }
        public decimal HI_52_WK { get; set; }
        public decimal LO_52_WK { get; set; }
    }
    public class PDTradeCollection
    {
        public List<PDTrade> PDTradeInfo { get; set; }
    }
}
