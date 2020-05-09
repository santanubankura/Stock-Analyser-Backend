using System;
using System.Net;
using System.Windows.Forms;
using System.IO.Compression;
using System.Configuration;
using SecuritiesUpDate.Service;

namespace SecuritiesUpDate
{
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
        }

        public static bool CheckForInternetConnection()
        {
            try
            {
                using (var client = new WebClient())
                using (client.OpenRead("http://google.com/generate_204"))
                    return true;
            }
            catch
            {
                return false;
            }
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            try
            {
                timer1.Enabled = true;
                lblConnection.Visible = true;
                if (CheckForInternetConnection())
                {
                    lblConnection.Text = "Available";
                    lblConnection.BackColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblConnection.Text = "Not Available";
                    lblConnection.BackColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            bool isNotDone = true;
            if (CheckForInternetConnection())
            {
                lblConnection.Text = "Available";
                lblConnection.BackColor = System.Drawing.Color.Green;
                DateTime transactionDate = DateTime.Now.AddDays(-1);

                string retVal = GetDownload(transactionDate,out isNotDone);

                if (retVal != "" && !isNotDone)
                {
                    bool response = new ExtractData().ExtractPd(retVal, transactionDate);

                    if(response)
                        textBox1.Text += DateTime.Now + " Pd Data extracted. And Saved Into db" + System.Environment.NewLine;
                }
            }
            else
            {
                lblConnection.Text = "Not Available";
                lblConnection.BackColor = System.Drawing.Color.Red;
            }
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            bool isNotDone = true;
            if (CheckForInternetConnection())
            { 
                string retVal = GetDownload(dtpDate.Value, out isNotDone);

                if (retVal != "")
                {
                    bool response = new ExtractData().ExtractPd(retVal, dtpDate.Value);

                    if (response)
                        textBox1.Text += DateTime.Now + " Pd Data extracted. And Saved Into db" + System.Environment.NewLine;
                }
            }
        }

        public string GetDownload(DateTime transactionDate, out bool isNotDone)
        {
            string folderName = "";
            isNotDone = true;
            try
            {
                DateTime Mydate;
                Mydate = transactionDate;
                var MyYear = Mydate.Year.ToString();
                string MyMonth = Mydate.Month.ToString().PadLeft(2, '0');
                string MyDay = Mydate.Day.ToString().PadLeft(2, '0');
                string DteString = MyYear + MyMonth + "cm" + MyDay + MyMonth + MyYear;
                string MyAddress = ConfigurationManager.AppSettings["BaseUrl"] + MyDay.ToString() + MyMonth.ToString() + MyYear.ToString().Substring(2, 2) + ".zip";
                string fileName = ConfigurationManager.AppSettings["GetFolderName"] + "StockData" + MyDay.ToString() + MyMonth.ToString() + MyYear.ToString().Substring(2, 2) + ".zip";
                string myStringWebResource = null;

                string subPath = ConfigurationManager.AppSettings["ExtractFolderName"] + "StockData" + MyDay.ToString() + MyMonth.ToString() + MyYear.ToString().Substring(2, 2);
                folderName = subPath;
                bool exists = System.IO.Directory.Exists(ConfigurationManager.AppSettings["ExtractFolderName"] + "StockData" + MyDay.ToString() + MyMonth.ToString() + MyYear.ToString().Substring(2, 2));

                if (!exists)
                {
                    isNotDone = false;
                    WebClient myWebClient = new WebClient();
                    myWebClient.Headers.Add("User-Agent: Other");
                    myStringWebResource = fileName;
                    myWebClient.DownloadFile(MyAddress, fileName);
                    textBox1.Text += DateTime.Now + " " + fileName + " generated." + System.Environment.NewLine;

                    System.IO.Directory.CreateDirectory(subPath);
                    ZipFile.ExtractToDirectory(fileName, subPath);
                    textBox1.Text += DateTime.Now + " " + fileName + " extracted." + System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            return folderName;
        }

    }
}
