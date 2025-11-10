// // OKTA helper module for REST operations (list users, get user, update user, groups, membership)
// // Uses axios for HTTP calls. Uses env vars: OKTA_BASE_URL, OKTA_API_TOKEN
// const axios = require('axios');

// const OKTA_BASE_URL = process.env.OKTA_BASE_URL; // e.g., https://dev-123456.okta.com
// const OKTA_API_TOKEN = process.env.OKTA_API_TOKEN;

// //const OKTA_BASE_URL = 'https://rbgcatman-auth-login.dev.mckesson.ca'; // e.g., https://dev-123456.okta.com
// //const OKTA_API_TOKEN = '00K-K9efVevUjW960u7PSQmliff-J8rxqOmYGZyPNa';

// if (!OKTA_BASE_URL || !OKTA_API_TOKEN) {
//   console.warn('OKTA_BASE_URL or OKTA_API_TOKEN not set. Okta API calls will fail until configured.');
// }

// const api = axios.create({
//   baseURL: `${OKTA_BASE_URL}/api/v1`,
//   timeout: 15000,
//   headers: {
//     Authorization: `SSWS ${OKTA_API_TOKEN}`,
//     'Content-Type': 'application/json',
//     Accept: 'application/json',
//   },
// });

// /* -----------------------------
//  * UTILITY HELPERS
//  * ----------------------------- */

// /** Get all groups starting with MFG */
// async function listMFGGroups() {
//   const resp = await api.get('/groups', { params: { q: 'MFG' } });
//   const groups = resp.data || [];
//   return groups.filter(g => g.profile?.name?.toUpperCase().startsWith('MFG'));
// }

// // /** Get all users in a specific group */
// // async function getGroupUsers(groupId) {
// //     const resp = await api.get(`/groups/${groupId}/users`);
// //     return resp.data || [];
// // }

// /** Transform Okta user into CAP-friendly format */
// function transformOktaUser(user, groups = []) {
//   return {
//     id: user.id,
//     status: user.status,
//     login: user.profile?.login,
//     firstName: user.profile?.firstName,
//     lastName: user.profile?.lastName,
//     email: user.profile?.email,
//     mfgName: user.profile?.mfgName || null,
//     manufacturerNumber: Array.isArray(user.profile?.manufacturerNumber)
//       ? user.profile.manufacturerNumber.join(', ')
//       : user.profile?.manufacturerNumber || null,
//     salesOrg: user.profile?.salesOrg || null,
//     salesOffice: user.profile?.salesOffice || null,
//     profitCentre: user.profile?.profitCentre || user.profile?.profitCenter || null,
//     groupIds: Array.isArray(groups) ? groups.map(g => g.id).join(', ') : (groups || ''),
//     groupNames: Array.isArray(groups) ? groups.map(g => g.profile?.name || g.name).join(', ') : (groups || ''),
//   };
// }

// /* -----------------------------
//  * MAIN EXPORTS
//  * ----------------------------- */

// async function listMFGUsers() {
//     const mfgGroups = await listMFGGroups();
//     const userMap = new Map();

//     for (const g of mfgGroups) {
//         const users = await getGroupUsers(g.id);
//         for (const u of users) {
//             let existing = userMap.get(u.id);
//           if (!existing) {
//               existing = transformOktaUser(u, []);
//               existing.groupNames = [];
//               existing.groupIds = [];
//           }
//           existing.groupNames.push(g.profile.name);
//           existing.groupIds.push(g.id);
//           userMap.set(u.id, existing);
//         }
//     }

//     return Array.from(userMap.values()).map(u => ({
//         ...u,
//         groupNames: u.groupNames.join(', '),
//         groupIds: u.groupIds.join(', '),
//     }));
// }

// async function getUser(id) {
//   const resp = await api.get(`/users/${encodeURIComponent(id)}`);
//   return resp.data;
// }

// async function updateUser(id, payload) {
//   if (payload.profile) {
//     await api.post(`/users/${encodeURIComponent(id)}`, { profile: payload.profile });
//   }

//   if (payload.groupIds) {
//     const currentGroupsResp = await api.get(`/users/${encodeURIComponent(id)}/groups`);
//     const currentGroupIds = (currentGroupsResp.data || []).map(g => g.id);
//     const desired = Array.isArray(payload.groupIds) ? payload.groupIds : [payload.groupIds];

//     for (const gid of desired) {
//       if (!currentGroupIds.includes(gid)) {
//         await api.put(`/groups/${encodeURIComponent(gid)}/users/${encodeURIComponent(id)}`);
//       }
//     }

//     // for (const gid of currentGroupIds) {
//     //   if (!desired.includes(gid)) {
//     //     await api.delete(`/groups/${encodeURIComponent(gid)}/users/${encodeURIComponent(id)}`);
//     //   }
//     // }
//   }

//   const updated = await api.get(`/users/${encodeURIComponent(id)}`);
//   return updated.data;
// }

// async function listGroups({ limit = 200 } = {}) {
//   const resp = await api.get('/groups', { params: { limit } });
//   return resp.data;
// }

// async function getUserGroups(userId) {
//   const resp = await api.get(`/users/${encodeURIComponent(userId)}/groups`);
//   return resp.data;
// }

// /* -----------------------------
//  * Lifecycle helpers: activate / deactivate
//  * ----------------------------- */

// // Activate a user (Okta API: POST /api/v1/users/{id}/lifecycle/activate)
// async function activateUser(id) {
//   // Okta supports optional query param sendEmail; we'll not send email by default
//   try {
//     const resp = await api.post(`/users/${encodeURIComponent(id)}/lifecycle/activate`);
//     return resp.data;
//   } catch (e) {
//     // Some Okta orgs require query param or different endpoint; bubble the error
//     console.error("activateUser error:", e?.response?.data || e.message);
//     throw e;
//   }
// }

// // Deactivate a user (Okta API: POST /api/v1/users/{id}/lifecycle/deactivate)
// async function deactivateUser(id) {
//   try {
//     const resp = await api.post(`/users/${encodeURIComponent(id)}/lifecycle/deactivate`);
//     return resp.data;
//   } catch (e) {
//     console.error("deactivateUser error:", e?.response?.data || e.message);
//     throw e;
//   }
// }

// module.exports = {
//   listMFGUsers,
//   transformOktaUser,
//   getUser,
//   updateUser,
//   listGroups,
//   getUserGroups,
//   activateUser,
//   deactivateUser
// };
/**
 * OKTA Helper Module
 * -----------------------------
 * Provides utilities for user + group management via Okta REST API.
 * Reads environment variables lazily to work with Cloud Foundry and local .env setups.
 */

const axios = require('axios')

/**
 * Create a new axios instance for Okta API
 * Reads environment variables at runtime to avoid "undefined" issues in CF.
 */
function getOktaApiInstance() {
  const OKTA_BASE_URL = process.env.OKTA_API_URL;
  const OKTA_API_TOKEN = process.env.OKTA_API_TOKEN;

  if (!OKTA_BASE_URL || !OKTA_API_TOKEN) {
    console.error('❌ Missing OKTA_BASE_URL or OKTA_API_TOKEN');
    throw new Error('Missing Okta configuration environment variables.');
  }

  return axios.create({
    baseURL: `${OKTA_BASE_URL.replace(/\/$/, '')}/api/v1`,
    timeout: 15000,
    headers: {
      Authorization: `SSWS ${OKTA_API_TOKEN}`,
      'Content-Type': 'application/json',
      Accept: 'application/json',
    },
  });
}

/* ----------------- Group Utilities ------------------- */

/**
 * List Okta groups (default query: "MFG")
 */
async function listGroups(query = 'MFG') {
  const api = getOktaApiInstance();
  try {
    const resp = await api.get('/groups', { params: { q: query } });
    return (resp.data || []).map((g) => ({
      id: g.id,
      name: g.profile?.name || g.id,
      description: g.profile?.description || '',
    }));
  } catch (error) {
    console.error('❌ [listGroups] Error:', error.response?.data || error.message);
    throw error;
  }
}

/* ----------------- User Utilities ------------------- */

/**
 * Create a new Okta user and assign groups
 */
async function createUser(profile, groupIds = []) {
  const api = getOktaApiInstance();

  try {
    const payload = { profile: { ...profile, login: profile.email } };
    const resp = await api.post('/users?activate=true', payload);
    const userId = resp.data?.id;

    if (groupIds?.length) {
      for (const groupId of groupIds) {
        await api.put(`/groups/${encodeURIComponent(groupId)}/users/${encodeURIComponent(userId)}`);
      }
    }

    console.log(`✅ Created Okta user: ${userId}`);
    return { id: userId, status: resp.data?.status };
  } catch (error) {
    console.error('❌ [createUser] Error:', error.response?.data || error.message);
    throw error;
  }
}

/**
 * Update an existing Okta user (and optionally group memberships)
 */
async function updateUser(id, profile, groupIds = []) {
  const api = getOktaApiInstance();

  try {
    if (profile) {
      await api.post(`/users/${encodeURIComponent(id)}`, { profile });
    }

    if (groupIds?.length > 0) {
      const current = await api.get(`/users/${id}/groups`);
      const currentIds = (current.data || []).map((g) => g.id);

      for (const groupId of groupIds) {
        if (!currentIds.includes(groupId)) {
          await api.put(`/groups/${groupId}/users/${id}`);
        }
      }
    }

    console.log(`✅ Updated Okta user: ${id}`);
    return { status: 'updated' };
  } catch (error) {
    console.error('❌ [updateUser] Error:', error.response?.data || error.message);
    throw error;
  }
}

/**
 * Get all groups for a given user
 */
async function getUserGroups(id) {
  const api = getOktaApiInstance();
  try {
    const resp = await api.get(`/users/${id}/groups`);
    return (resp.data || []).map((g) => ({
      id: g.id,
      name: g.profile?.name || g.id,
    }));
  } catch (error) {
    console.error('❌ [getUserGroups] Error:', error.response?.data || error.message);
    throw error;
  }
}

/**
 * List all users across MFG groups
 */
async function listUsersInMFGGroups() {
  const api = getOktaApiInstance();
  const userMap = new Map();

  try {
    const groups = await listGroups('MFG');

    for (const group of groups) {
      const users = await api.get(`/groups/${group.id}/users`);
      for (const u of users.data || []) {
        const existing = userMap.get(u.id) || {
          id: u.id,
          firstName: u.profile?.firstName,
          lastName: u.profile?.lastName,
          email: u.profile?.email,
          login: u.profile?.login,
          salesOrg: u.profile?.salesOrg,
          salesOffice: u.profile?.salesOffice,
          profitCentre: u.profile?.profitCentre,
          mfgName: u.profile?.mfgName,
          manufacturerNumber: Array.isArray(u.profile?.manufacturerNumber)
            ? u.profile.manufacturerNumber.join(', ')
            : u.profile?.manufacturerNumber || '',
          groupIds: [],
          groupNames: [],
        };

        existing.groupIds.push(group.id);
        existing.groupNames.push(group.name);
        userMap.set(u.id, existing);
      }
    }

    console.log(`✅ Loaded ${userMap.size} unique Okta users from MFG groups`);
    return Array.from(userMap.values()).map((u) => ({
      ...u,
      groupIds: u.groupIds.join(', '),
      groupNames: u.groupNames.join(', '),
    }));
  } catch (error) {
    console.error('❌ [listUsersInMFGGroups] Error:', error.response?.data || error.message);
    throw error;
  }
}

/* -------- Lifecycle Helpers -------- */

/**
 * Activate user in Okta
 */
async function activateUser(id) {
  const api = getOktaApiInstance();
  try {
    const resp = await api.post(`/users/${id}/lifecycle/activate`);
    console.log(`✅ Activated user: ${id}`);
    return resp.data;
  } catch (error) {
    console.error('❌ [activateUser] Error:', error.response?.data || error.message);
    throw error;
  }
}

/**
 * Deactivate user in Okta
 */
async function deactivateUser(id) {
  const api = getOktaApiInstance();
  try {
    const resp = await api.post(`/users/${id}/lifecycle/deactivate`);
    console.log(`✅ Deactivated user: ${id}`);
    return resp.data;
  } catch (error) {
    console.error('❌ [deactivateUser] Error:', error.response?.data || error.message);
    throw error;
  }
}

/* ----------------- Exports ------------------- */

module.exports = {
  listGroups,
  createUser,
  updateUser,
  listUsersInMFGGroups,
  activateUser,
  deactivateUser,
  getUserGroups,
};

