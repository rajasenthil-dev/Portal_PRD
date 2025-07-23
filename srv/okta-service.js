const cds = require("@sap/cds");
const axios = require("axios");

module.exports = cds.service.impl(async function () {
    
  const OKTA_API_TOKEN = '00Rpkzmvl-3WrAG_z3FewYqZeKCzaSax09cF1NR5Ph';
  const OKTA_API_URL = 'https://rbgcatman-auth-login.dev.mckesson.ca/api/v1/users?activate=true';

  this.on('CreateUser', async (req) => {
    console.log("Action Hit!", req.data);
    try {
      const payload = req.data.input;

      // ✅ Build Okta User Creation Payload
      const oktaPayload = {
        profile: {
          firstName: payload.firstName,
          lastName: payload.lastName,
          email: payload.email,
          login: payload.login || payload.email,
          SalesOffice: payload.salesOffice,
          ProfitCentre: payload.profitCentre,
          SalesOrg: payload.salesOrg,
          ManufacturerNumber: payload.manufacturerNumbers,
          MFGName: payload.mfgName
        },
        groupIds: payload.selectedGroup // Optional: populate if you want to assign Okta group IDs
      };

      // ✅ Call Okta API
      const response = await axios.post(OKTA_API_URL, oktaPayload, {
        headers: {
          Authorization: `${OKTA_API_TOKEN}`,
          "Content-Type": "application/json"
        }
      });

      return {
        success: true,
        message: "User successfully created in Okta",
        userId: response.data.id
      };

    } catch (err) {
      console.error("Okta Error: ", err.response?.data || err.message);
      return {
        success: false,
        message: err.response?.data?.errorCauses?.[0]?.errorSummary || err.message,
        userId: ""
      };
    }
  });
});
