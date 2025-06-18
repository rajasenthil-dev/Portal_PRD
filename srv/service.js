const cds = require('@sap/cds');

/**
 * Implementation of ALL services.
 */
module.exports = cds.service.impl(function() {

    /**
     * This 'before' handler runs before any operation on any entity in this service.
     * It's the perfect place to prepare the user object for authorization by ensuring
     * the ManufacturerNumber is always an array.
     */
    this.before('*', async (req) => {
        // Normalization logic 
        const mfrnr = req.user?.attr?.ManufacturerNumber;
        if (mfrnr && !Array.isArray(mfrnr)) {
            req.user.attr.ManufacturerNumber = [mfrnr];
            console.log(`Normalized ManufacturerNumber to array:`, req.user.attr.ManufacturerNumber);
        }
    
    //     // NEW: Only do filter for READ events
    //     if (req.event === 'READ') {
    //         const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //         console.log(`Global READ handler - ManufacturerNumber: ${userManufacturer}`);
    
    //         if (userManufacturer === '0001000024') {
    //             console.log(`Applying exclusion filter for user 0001000024`);
    
    //             try {
    //                 req.query.where(`(CO_VKORG <> '1000' AND WERKS <> '1010')`);
    //             } catch (e) {
    //                 console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //             }
    //         }
    //     }
    });

    /**
     * This 'before READ' handler applies additional query filters for SALESBYCURRENT
     * based on user ManufacturerNumber.
     */
    this.before('READ', ['SALESBYCURRENT', 'SALESBYCURRENTWOPID'], async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`SALESBYCURRENT READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(CO_VKORG <> '1000' AND WERKS <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });
    this.before('READ', ['SBCSALESORG', 'RETVKORG'], async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`SBCSALESORG READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(CO_VKORG <> '1000')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    /**
     * This 'before READ' handler applies additional query filters for ITEMMASTER
     * based on user ManufacturerNumber.
     */
    this.before('READ', 'ITEMMASTER', async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`ITEMMAS READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(SALESORG <> '1000' AND BWKEY <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', 'ITEMMASSALESORG', async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`ITEMMASSALESORG READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(SALESORG <> '1000')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', ['INVENTORYSTATUS', 'INVENTORYBYLOT', 'INVENTORYVALUATION'], async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`INVENTORYSTATUS READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(VKBUR <> '1000' AND PLANT <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', ['INVSTATUSVKBUR', 'INVENTORYBYLOT', 'INVENTORYVALUATION'], async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`INVSTATUSVKBUR READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(VKBUR <> '1000')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', 'INVENTORYAUDITTRAIL', async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`INVENTORYAUDITTRAIL READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(SALES_ORG <> '1000' AND WERKS <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', 'IATSALESORG', async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`IATSALESORG READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(SALES_ORG <> '1000' AND WERKS <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', [
        'CASHJOURNAL', 
        'INVENTORYSNAPSHOT', 
        'FINCJSALESORG', 
        'IHSALESORG', 
        'OPENAR', 
        'OPENARSALESORG', 
        'CUSTOMERMASTER',
        'CMSALESORG',
        'SHIPPINGHISTORY',
        'SHVKORG',
        'PRICING',
        'PRICINGSALESORG',
        'OOVKORG',
        'BOVKORG'
    ], async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`CASHJOURNAL READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(VKORG <> '1000')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', ['INVOICEHISTORY', 'INVENTORYSNAPSHOT'], async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`INVOICEHISTORY READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(VKORG <> '1000' AND WERKS <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', ['OPENORDERS', 'BACKORDERS'], async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`OPENORDERS READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(VKORG <> '1000' AND PLANT <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    this.before('READ', 'RETURNS', async (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        console.log(`SALESBYCURRENT READ handler - ManufacturerNumber: ${userManufacturer}`);

        if (userManufacturer === '0001000019') {
            console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

            try {
                req.query.where(`(CO_VKORG <> '1000' AND PLANT <> '1010')`);
            } catch (e) {
                console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
            }
        }
    });

    // --- START: Refactored logic for role-based field visibility ---

    // 1. Define the list of entities that need this special visibility logic.
    const entitiesWithRoleBasedMfrnr = ['INVOICEHISTORY', 'SALESBYCURRENT'];

    // 2. Define the 'after' handler to distinguish between Internal and External users.
    const addRoleBasedVisibilityFlag = function(results, req) {
        // If there are no results (e.g., a read for a non-existent ID), exit.
        if (!results) {
            return;
        }

        // --- New Logic ---
        // Check if the user is an internal user. We assume internal users have a specific role.
        // Replace 'Internal' with the actual role name that identifies your internal users.
        const isInternalUser = req.user.is('Internal'); 
        console.log(`Checking user roles. Is Internal User: ${isInternalUser}`);

        // The MFRNR column should be HIDDEN only for users who are NOT internal.
        const shouldHideMfrnr = !isInternalUser;

        // Ensure 'results' is an array to handle both single-item reads (which return an object)
        // and multi-item reads (which return an array).
        const data = Array.isArray(results) ? results : [results];

        // Iterate over each record to set the virtual field's value.
        data.forEach(record => {
            // The virtual field 'isMfrnrHidden' must be defined in your data-model.cds.
            // It will be true if the user is NOT internal, and false if they ARE internal.
            record.isMfrnrHidden = shouldHideMfrnr;
        });
    };

    // 3. Apply the handler to all 'READ' operations for the specified entities.
    this.after('READ', entitiesWithRoleBasedMfrnr, addRoleBasedVisibilityFlag);

    // --- END: Refactored logic ---
    

    // You can add other handlers for other entities or operations (CREATE, UPDATE, etc.) here.
});
