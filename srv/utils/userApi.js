const axios = require('axios');

async function getUserAttributes(req) {
    const userApiUrl = process.env.USER_API_URL || "https://services.usermanagement.us20cf.hana.ondemand.com";
    const token = req.headers.authorization;

    try {
        const response = await axios.get(`${userApiUrl}/v1/me`, {
            headers: {
                Authorization: token
            }
        });
        return response.data;
    } catch (error) {
        console.error("Error fetching user attributes", error);
        throw new Error("Could not fetch user attributes");
    }
}

module.exports = { getUserAttributes};