const cds = require('@sap/cds');

cds.on('bootstrap', (app) => {
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


//     app.use((req, res, next) => {
//         req.user = {
//             id: 'mockUser',
//             roles: [],
//             attr: {
//                 //LIFNR: '0001000000'
//                 //LIFNR: '0001000083'
//                 LIFNR: 'BP3000'
//             }
//         };
//         next();
//     });
// });
// const cds = require('@sap/cds');
// const express = require('express');

// cds.on('bootstrap', (app) => {
//     app.use('/assets', express.static('assets'))
// });


