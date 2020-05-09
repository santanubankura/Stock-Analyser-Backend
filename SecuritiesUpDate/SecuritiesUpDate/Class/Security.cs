using System;

namespace SecuritiesUpDate.Class
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
}
