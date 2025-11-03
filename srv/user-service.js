const cds = require('@sap/cds');
const okta = require('./okta-helper');

module.exports = cds.service.impl(async function () {
  const { OKTAUsers, LocalUserData } = this.entities;

  /** Utility: Flatten arrays → strings for UI */
  const ensureString = (val) => {
    if (Array.isArray(val)) return val.join(', ');
    if (val === null || val === undefined) return '';
    return String(val);
  };

  /** Utility: Split strings → arrays for Okta */
  const parseToArray = (val) => {
    if (Array.isArray(val)) return val;
    if (!val) return [];
    return val.split(',').map((s) => s.trim()).filter(Boolean);
  };

  /** Admin check */
  function isAdmin(req) {
    if (process.env.STRICT_ROLE_CHECK === 'true') {
      const roles = (req.user && req.user.roles) || [];
      return roles.includes('admin') || roles.includes('Admin');
    }
    return true;
  }

  /** ---------------------- READ HANDLER ---------------------- */
  this.on('READ', OKTAUsers, async (req) => {
    console.log('📡 Fetching MFG users from Okta...');

    const oktaUsers = await okta.listMFGUsers();
    const local = await SELECT.from(LocalUserData);

    const merged = oktaUsers.map((u) => {
      const localRow = local.find((r) => r.id === u.id);
      if (!localRow) {
        return {
          ...u,
          manufacturerNumber: ensureString(u.manufacturerNumber),
          groupNames: ensureString(u.groupNames),
          groupIds: ensureString(u.groupIds),
        };
      }

      const finalUser = {
        ...u,
        ...localRow,
        manufacturerNumber: ensureString(localRow.manufacturerNumber || u.manufacturerNumber),
        groupNames: ensureString(localRow.groupNames || u.groupNames),
        groupIds: ensureString(localRow.groupIds || u.groupIds),
        mfgName: localRow.manufacturerName || u.mfgName,
        salesOrg: localRow.salesOrg || u.salesOrg,
        salesOffice: localRow.salesOffice || u.salesOffice,
        profitCentre: localRow.profitCentre || u.profitCentre,
      };

      return finalUser;
    });

    const top = req.query?.SELECT?.limit?.rows?.val || 50;
    const skip = req.query?.SELECT?.limit?.offset?.val || 0;
    req._.count = merged.length;
    const paginated = merged.slice(skip, skip + top);

    console.log(`✅ Returning ${paginated.length} of ${merged.length} users`);
    return paginated;
  });

  /** ---------------------- UPDATE HANDLER ---------------------- */
  this.on('UPDATE', OKTAUsers, async (req) => {
  
  // ✅ Extract correct string ID, CAP sometimes wraps parameters
  let id = req.params?.[0]?.id || req.params?.[0] || req.data.id || req.data.ID;

  if (typeof id === "object") {
    id = id.id;  // ✅ unwrap CAP object format
  }

  if (!id || typeof id !== "string") {
    return req.error(400, `Invalid ID received: ${JSON.stringify(req.params)}`);
  }
  if (!id) return req.error(400, 'Missing user id');

  const payload = req.data || {};
  const oktaProfile = {};
  const oktaPayload = { profile: oktaProfile };  // ✅ Declare FIRST

  // ✅ Basic profile fields
  if (payload.firstName !== undefined) oktaProfile.firstName = payload.firstName;
  if (payload.lastName !== undefined) oktaProfile.lastName = payload.lastName;
  if (payload.email !== undefined) {
    oktaProfile.email = payload.email;
    oktaProfile.login = payload.email;
  }

  // ✅ Custom Okta attributes
  if (payload.salesOrg !== undefined) oktaProfile.salesOrg = payload.salesOrg;
  if (payload.salesOffice !== undefined) oktaProfile.salesOffice = payload.salesOffice;
  if (payload.profitCentre !== undefined) oktaProfile.profitCentre = payload.profitCentre;
  if (payload.mfgName !== undefined) oktaProfile.mfgName = payload.mfgName;

  // ✅ Convert from string → array (Okta requirement)
  if (payload.manufacturerNumber) {
    oktaPayload.profile.manufacturerNumber =
      payload.manufacturerNumber.split(",").map(s => s.trim());
  }

  if (payload.groupIds) {
    oktaPayload.groupIds =
      payload.groupIds.split(",").map(s => s.trim());
  }

  // ✅ Update Okta only if fields are present
  let oktaUpdated = null;
  if (Object.keys(oktaProfile).length > 0 || oktaPayload.groupIds) {
    oktaUpdated = await okta.updateUser(id, oktaPayload);
  }

  // ✅ Persist clean string values into HDI DB
  const localFields = {
    id,
    manufacturerName: payload.mfgName || null,
    manufacturerNumber: payload.manufacturerNumber || "",
    salesOrg: payload.salesOrg || null,
    salesOffice: payload.salesOffice || null,
    profitCentre: payload.profitCentre || null,
    groupNames: payload.groupNames || "",
    groupIds: payload.groupIds || ""
  };

  const existing = await SELECT.one(LocalUserData).where({ id });
  if (existing) {
    await UPDATE(LocalUserData).set(localFields).where({ id });
  } else {
    await INSERT.into(LocalUserData).entries(localFields);
  }

  // ✅ Return merged latest user
  return await this.read(OKTAUsers, id);
});

  /** ---------------------- GROUPS HANDLER ---------------------- */
  this.on('READ', 'OktaGroups', async () => {
    const groups = await okta.listGroups({ limit: 1000 });
    return (groups || []).map((g) => ({
      id: g.id,
      name: g.profile?.name || g.name,
    }));
  });
});
