// OKTA helper module for REST operations (list users, get user, update user, groups, membership)
// Uses axios for HTTP calls. Uses env vars: OKTA_BASE_URL, OKTA_API_TOKEN
const axios = require('axios');

//const OKTA_BASE_URL = process.env.OKTA_BASE_URL; // e.g., https://dev-123456.okta.com
//const OKTA_API_TOKEN = process.env.OKTA_API_TOKEN;

const OKTA_BASE_URL = 'https://rbgcatman-auth-login.dev.mckesson.ca'; // e.g., https://dev-123456.okta.com
const OKTA_API_TOKEN = '00K-K9efVevUjW960u7PSQmliff-J8rxqOmYGZyPNa';

if (!OKTA_BASE_URL || !OKTA_API_TOKEN) {
  console.warn('OKTA_BASE_URL or OKTA_API_TOKEN not set. Okta API calls will fail until configured.');
}

const api = axios.create({
  baseURL: `${OKTA_BASE_URL}/api/v1`,
  timeout: 15000,
  headers: {
    Authorization: `SSWS ${OKTA_API_TOKEN}`,
    'Content-Type': 'application/json',
    Accept: 'application/json',
  },
});

/* -----------------------------
 * UTILITY HELPERS
 * ----------------------------- */

/** Get all groups starting with MFG */
async function listMFGGroups() {
  const resp = await api.get('/groups', { params: { q: 'MFG' } });
  const groups = resp.data || [];
  return groups.filter(g => g.profile?.name?.toUpperCase().startsWith('MFG'));
}

/** Get all users in a specific group */
async function getGroupUsers(groupId) {
  const resp = await api.get(`/groups/${groupId}/users`);
  return resp.data || [];
}

/** Transform Okta user into CAP-friendly format */
function transformOktaUser(user, groups = []) {
  return {
    id: user.id,
    status: user.status,
    login: user.profile?.login,
    firstName: user.profile?.firstName,
    lastName: user.profile?.lastName,
    email: user.profile?.email,
    mfgName: user.profile?.mfgName || null,
    manufacturerNumber: Array.isArray(user.profile?.manufacturerNumber)
      ? user.profile.manufacturerNumber.join(', ')
      : user.profile?.manufacturerNumber || null,
    salesOrg: user.profile?.salesOrg || null,
    salesOffice: user.profile?.salesOffice || null,
    profitCentre: user.profile?.profitCentre || user.profile?.profitCenter || null,
    groupIds: Array.isArray(groups) ? groups.map(g => g.id).join(', ') : (groups || ''),
    groupNames: Array.isArray(groups) ? groups.map(g => g.profile?.name || g.name).join(', ') : (groups || ''),
  };
}

/* -----------------------------
 * MAIN EXPORTS
 * ----------------------------- */

async function listMFGUsers() {
  const mfgGroups = await listMFGGroups();
  const userMap = new Map();

  for (const g of mfgGroups) {
    const users = await getGroupUsers(g.id);
    for (const u of users) {
      let existing = userMap.get(u.id);
      if (!existing) {
        existing = transformOktaUser(u, []);
        existing.groupNames = [];
        existing.groupIds = [];
      }
      existing.groupNames.push(g.profile.name);
      existing.groupIds.push(g.id);
      userMap.set(u.id, existing);
    }
  }

  return Array.from(userMap.values()).map(u => ({
    ...u,
    groupNames: u.groupNames.join(', '),
    groupIds: u.groupIds.join(', '),
  }));
}

async function getUser(id) {
  const resp = await api.get(`/users/${encodeURIComponent(id)}`);
  return resp.data;
}

async function updateUser(id, payload) {
  if (payload.profile) {
    await api.post(`/users/${encodeURIComponent(id)}`, { profile: payload.profile });
  }

  if (payload.groupIds) {
    const currentGroupsResp = await api.get(`/users/${encodeURIComponent(id)}/groups`);
    const currentGroupIds = (currentGroupsResp.data || []).map(g => g.id);
    const desired = Array.isArray(payload.groupIds) ? payload.groupIds : [payload.groupIds];

    for (const gid of desired) {
      if (!currentGroupIds.includes(gid)) {
        await api.put(`/groups/${encodeURIComponent(gid)}/users/${encodeURIComponent(id)}`);
      }
    }

    for (const gid of currentGroupIds) {
      if (!desired.includes(gid)) {
        await api.delete(`/groups/${encodeURIComponent(gid)}/users/${encodeURIComponent(id)}`);
      }
    }
  }

  const updated = await api.get(`/users/${encodeURIComponent(id)}`);
  return updated.data;
}

async function listGroups({ limit = 200 } = {}) {
  const resp = await api.get('/groups', { params: { limit } });
  return resp.data;
}

async function getUserGroups(userId) {
  const resp = await api.get(`/users/${encodeURIComponent(userId)}/groups`);
  return resp.data;
}

/* -----------------------------
 * Lifecycle helpers: activate / deactivate
 * ----------------------------- */

// Activate a user (Okta API: POST /api/v1/users/{id}/lifecycle/activate)
async function activateUser(id) {
  // Okta supports optional query param sendEmail; we'll not send email by default
  try {
    const resp = await api.post(`/users/${encodeURIComponent(id)}/lifecycle/activate`);
    return resp.data;
  } catch (e) {
    // Some Okta orgs require query param or different endpoint; bubble the error
    console.error("activateUser error:", e?.response?.data || e.message);
    throw e;
  }
}

// Deactivate a user (Okta API: POST /api/v1/users/{id}/lifecycle/deactivate)
async function deactivateUser(id) {
  try {
    const resp = await api.post(`/users/${encodeURIComponent(id)}/lifecycle/deactivate`);
    return resp.data;
  } catch (e) {
    console.error("deactivateUser error:", e?.response?.data || e.message);
    throw e;
  }
}

module.exports = {
  listMFGUsers,
  transformOktaUser,
  getUser,
  updateUser,
  listGroups,
  getUserGroups,
  activateUser,
  deactivateUser
};
