// srv/SALES.js  <-- RENAMED FILE
const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  // This refers to the INVOICEHISTORY entity within the 'SALES' service
  const { INVOICEHISTORY } = this.entities;

  // READ handler for INVOICEHISTORY entity
  this.on('READ', INVOICEHISTORY, async (req) => {
    console.log('INVOICEHISTORY READ handler triggered!'); // Add this line for debugging

    // Execute the original query to fetch the data
    const results = await cds.tx(req).run(req.query);

    // Ensure results is an array (it might be a single object if fetching by key)
    const dataToProcess = Array.isArray(results) ? results : [results];

    // Define the fields you want to check for null/blank
    const stringFieldsToCheck = [
      'BKTXT',
      'LFDAT',
      'ORT01',
      'BSTKD',
      'TRACKN',
      'PATIENT_ID',
      'BEZEI',
      'MFRNR_NAME',
      // Add any other string fields you want to process
      'CURRENT',
      'ORDER_TYPE',
      'FKDAT',
      'PLANT_NAME',
      'WAERK' // Assuming WAERK could also be null/blank if not provided
    ];

    const decimalFieldsToCheck = [
      'CAL_GST',
      'CAL_PST',
      'TSL_AMOUNT'
      // Add any other decimal fields you want to process
    ];

    // Iterate over each record in the results
    dataToProcess.forEach(record => {
      // Process String fields
      stringFieldsToCheck.forEach(field => {
        // Check if the field exists and is null or an empty string
        if (record.hasOwnProperty(field) && (record[field] === null || record[field] === '')) {
          record[field] = '--';
        }
      });

      // Process Decimal fields
      decimalFieldsToCheck.forEach(field => {
        // Check if the field exists and is null
        if (record.hasOwnProperty(field) && record[field] === null) {
          record[field] = '--';
        }
        // Optional: if you want to handle 0 for decimals as well
        // if (record.hasOwnProperty(field) && record[field] === 0) {
        //   record[field] = '--';
        // }
      });
    });

    return results; // Return the modified results
  });
});