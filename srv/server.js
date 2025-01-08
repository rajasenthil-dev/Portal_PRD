// const cds = require('@sap/cds');
// const jwt = require('jsonwebtoken'); // Ensure you install this package
// const axios = require('axios'); // For calling user-api
// const { getUserAttributes } = require('./utils/userApi');

// // Middleware to authenticate and enrich user info
// // async function authMiddleware(req, res, next) {
// //   const authHeader = req.headers['authorization'];
// //   if (!authHeader) {
// //     console.log('No Authorization Header Found');
// //     return res.status(401).send('Unauthorized');
// //   } else {
// //     console.log('User Token: ', authHeader)
// //   }

// //   try {
// //     // Extract and decode JWT token
// //     const token = authHeader.split(' ')[1];
// //     const decoded = jwt.decode(token);

// //     if (!decoded) {
// //       console.log('Invalid Token');
// //       return res.status(401).send('Invalid Token');
// //     }
// //     // Define the app router URL (update with your app router domain)
// //     const appRouterBaseUrl = process.env.APP_ROUTER_BASE_URL || `https://discovery-sunrise.authentication.us20.hana.ondemand.com`;

// //     // Construct the user-api URL
// //     const userApiUrl = `${appRouterBaseUrl}/config?action=who&details=true`;

// //     // Call the user-api to fetch user attributes
// //     const response = await axios.get(userApiUrl, {
// //       headers: { Authorization: authHeader },
// //     });

// //     const userInfo = response.data
    
    

// //     // Create the enriched user object
// //     console.log('User Info:', userInfo)

// //     console.log('User authenticated:', req.user);
// //     next();
// //   } catch (error) {
// //     console.error('Error in authMiddleware:', error.message);
// //     res.status(500).send('Internal Server Error');
// //   }
// // }

// //module.exports = authMiddleware;

// cds.on('bootstrap', (app) => {
//   // console.log('CAP is Starting.....');

//   // // Use the authentication middleware
//   // app.use(authMiddleware);

//   // app.use((req, res, next) => {
//   //   if(req.user) {
//   //     console.log('UserInfo: ', req.user)
//   //   } else {
//   //     console.log('User not authenticated');
//   //   }
//   //   next();
//   // });
//   // Add custom middleware or routes
//   app.get('/mock-api/invoices/:number', (req, res) => {
//     const invoiceNumber = req.params.number;

//     // Simulated response for the mock API
//     const mockImageUrl = "https://via.placeholder.com/600x800.png?text=Invoice";
//     res.status(200).json({ imageUrl: mockImageUrl });
//   });
// });

// // Bootstrapping the CAP service
// module.exports = cds.server;





