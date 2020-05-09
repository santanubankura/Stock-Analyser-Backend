using Core.Entity.Securities;
using Data.Dal.Securities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Web.Api.Controllers
{
    /// <summary>
    /// User realted methods
    /// </summary>
    [RoutePrefix("Api/Securities")]
    public class SecuritiesController : ApiController
    {

        /// <summary>
        /// http://localhost:60669/Api/Securities/GetSecurities
        /// </summary>
        /// <param name="GetSecurities"></param>
        /// <returns>HttpResponseMessage</returns>
        [HttpGet]
        [AllowAnonymous]
        [Route("GetSecurities")]
        public HttpResponseMessage GetSecurities()
        {
            SecurityCollection retVal = new SecurityCollection();
            try
            {
                if (ModelState.IsValid)
                {
                    retVal = new SecurityDal().GetSecurities();
                }
                else
                {
                    throw new Exception("");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, retVal);
            return response;
        }


        /// <summary>
        /// http://localhost:60669/Api/Securities/GetSecurityStatus/59/01-Apr-2020/30-Apr-2020
        /// </summary>
        /// <param name="GetSecurityStatus"></param>
        /// <returns>HttpResponseMessage</returns>
        [HttpGet]
        [AllowAnonymous]
        [Route("GetSecurityStatus/{Id}/{FromDate}/{ToDate}")]
        public HttpResponseMessage GetSecurityStatus(int Id, DateTime FromDate, DateTime ToDate)
        {
            List<SecuritiesStatusChart> retValue = new List<SecuritiesStatusChart>();
            try
            {
                if (ModelState.IsValid)
                {
                    retValue = new SecurityDal().GetSecurityStatus(Id, FromDate, ToDate);
                }
                else
                {
                    throw new Exception("");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, retValue);
            return response;
        }
    }
}
