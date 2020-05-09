using System;
using System.Collections.Generic;

namespace Core.Entity.Securities
{
    public class Security
    {
        public Int64 Id { get; set; }
        public string SYMBOL { get; set; }
        public string SECURITY_NAME { get; set; }
        public string MKT { get; set; }
        public string SERIES { get; set; }

        // Virtual
        public string INDEX_NAME { get; set; }
    }
    public class SecurityCollection
    {
        public List<Security> SecurityInfo { get; set; }
    }
}
