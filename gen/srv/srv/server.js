const cds = require('@sap/cds');
cds.on('bootstrap', app => {
  // You can add custom routes or middleware here if needed
});


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


