
const cds = require('@sap/cds');

module.exports = async (srv) => {
    srv.before('READ', 'INVOICEHISTORY', async (req) => {
        let userManufacturerNumber = req.user.attr.ManufacturerNumber;

        if (!userManufacturerNumber) {
            req.query.where({ ManufacturerNumber: null });
        }
    })

    // --- User Permissions Function Handler (for UI logic) ---
    /**
     * Handle the custom function call to get UI permissions.
     * Corresponds to the function defined in catalog-service.cds.
     */
    srv.on('getUserPermissions', async (req) => {
        const permissions = {
            // Default: Assume the user SHOULD see the Patient ID
            shouldHidePatientId: false
        };

        // !!! IMPORTANT: Replace 'SalesViewerNoPatientId' below !!!
        // Use the ACTUAL role template name from your xs-security.json corresponding
        // to the BTP Role Collection (e.g., MFG_SalesBy_NoPatientId) for this app.
        const roleToCheck = 'MFG_Reports_NoPatientId_RC'; // <<< --- CHANGE THIS ROLE TEMPLATE NAME

        // Check if the user has the role indicating they SHOULD NOT see the ID
        if (req.user.is(roleToCheck)) {
            permissions.shouldHidePatientId = true;
        }

        cds.log('permissions').info(`User ${req.user.id} permissions check: shouldHidePatientId = ${permissions.shouldHidePatientId}`);
        return permissions; // Return the permissions object
    });
}
