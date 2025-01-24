const connectUtilsMiddleware = require('@sap/approuter/lib/middleware/connect-utils-middleware');
const axios = require('axios');

module.exports = async (req, res, next) => {
  if (!req.user) return next(); // Skip if no user object exists

  try {
    const userApiUrl = `${req.protocol}://${req.get('host')}/user-api`;
    const response = await axios.get(`${userApiUrl}/attributes`, {
      headers: { Authorization: `Bearer ${req.authInfo.token}` },
    });

    // Attach user attributes to the request object
    req.user.attr = response.data.attributes;
    console.log('User Attributes: ', req.user.attr);
    next();
  } catch (error) {
    console.error('Error fetching user attributes:', error.message);
    res.status(500).send('Failed to fetch user attributes.');
  }
};

