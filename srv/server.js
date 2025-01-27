const multer = require('multer');
const cds = require('@sap/cds');
const jwt = require('jsonwebtoken'); // Ensure you install this package
const axios = require('axios'); // For calling user-api
const { getUserAttributes } = require('./utils/userApi');
const express = require("express");
const { endswith } = require('@cap-js/hana/lib/cql-functions');
// // Set up multer for file handling (you can configure storage options based on your needs)
// const upload = multer({ storage: multer.memoryStorage() });

module.exports = cds.service.impl(async function () {


    
//   const { Manufacturers } = this.entities;

//   // Expose the action for uploading manufacturer details
//   this.on('uploadManufacturerDetails', upload.single('file'), async (req) => {
//     const { manufacturerNumber, MFGName, imageName } = req.data;
//     const file = req.file; // file will be available as raw binary data in req.file

//     // Check if the manufacturer already exists
//     const existingManufacturer = await SELECT.one.from(Manufacturers).where({ manufacturerNumber });
//     if (existingManufacturer) {
//       req.error(400, `Manufacturer with number ${manufacturerNumber} already exists.`);
//     }

//     // Connect to Object Store
//     const { url, clientid, clientsecret } = cds.env.services.ObjectStore.credentials;
//     const tokenResponse = await axios.post(`${url}/oauth/token`, null, {
//       auth: { username: clientid, password: clientsecret },
//       params: { grant_type: 'client_credentials' },
//     });
//     const token = tokenResponse.data.access_token;

//     // Generate unique object key for the image
//     const objectKey = `${manufacturerNumber}-${imageName}`;
//     console.log("Uploading Image.................")
//     // Upload image to Object Store
//     await axios.put(`${url}/v1/objects/${objectKey}`, file.buffer, { // use file.buffer for binary data
//       headers: {
//         Authorization: `Bearer ${token}`,
//         'Content-Type': 'image/png',
//       },
//     });

//     // Generate public URL for the uploaded image
//     const publicURL = `${url}/v1/objects/${objectKey}`;

//     // Save manufacturer details in the database
//     await INSERT.into(Manufacturers).entries({
//       manufacturerNumber,
//       MFGName,
//       imageName,
//       imageUrl: publicURL,
//     });
//     return { manufacturerNumber, MFGName, imageName, imageUrl: publicURL };
//   });
});

// Middleware to authenticate and enrich user info
async function authMiddleware(req, res, next) {
  const authHeader = req.headers['authorization'];
  const user = cds.User.privileged

  if (!authHeader) {
    console.log('No Authorization Header Found');
    return res.status(401).send('Unauthorized');
  } else {
    console.log('User Token: ', authHeader);
    
  }
  if(req) {
    console.log('User Is Logged in:')
  } else {
    console.log('No User Logged in')
  }
  next();
}

module.exports = authMiddleware;

cds.on('bootstrap', (app) => {
  console.log('CAP is Starting.....');

  // Use the authentication middleware
  app.use(authMiddleware);

  // Add custom middleware or routes
  app.get('/mock-api/invoices/:number', (req, res) => {
    const invoiceNumber = req.params.number;

    // Simulated response for the mock API
    const mockImageUrl = "https://via.placeholder.com/600x800.png?text=Invoice";
    res.status(200).json({ imageUrl: mockImageUrl });
  });
});

// Bootstrapping the CAP service
module.exports = cds.server;





