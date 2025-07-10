const cds = require('@sap/cds');
const deduplicateForInternal = require('./utils/deduplication')
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
    });

    // --- Mappings of entity to filters ---
    /**
     * Entity → Filter map for manufacturer 0001000019
     * (Sales Org 1000 and Plant 1010 excluded)
    */
    const entityFilterMapFor0001000019 = {
        SALESBYCURRENT: `(CO_VKORG <> '1000' AND WERKS <> '1010')`,
        SALESBYCURRENTWOPID: `(CO_VKORG <> '1000' AND WERKS <> '1010')`,
        SBCSALESORG: `(CO_VKORG <> '1000')`,
        RETVKORG: `(CO_VKORG <> '1000')`,
        ITEMMASTER: `(SALESORG <> '1000' AND BWKEY <> '1010')`,
        ITEMMASSALESORG: `(SALESORG <> '1000')`,
        INVENTORYSTATUS: `(VKBUR <> '1000' AND PLANT <> '1010')`,
        INVSTATUSVKBUR: `(VKBUR <> '1000')`,
        INVENTORYBYLOT: `(VKBUR <> '1000' AND PLANT <> '1010')`,
        INVENTORYVALUATION: `(VKBUR <> '1000' AND PLANT <> '1010')`,
        INVENTORYAUDITTRAIL: `(SALES_ORG <> '1000' AND WERKS <> '1010')`,
        IATSALESORG: `(SALES_ORG <> '1000' AND WERKS <> '1010')`,
        CASHJOURNAL: `(VKORG <> '1000')`,
        INVENTORYSNAPSHOT: `(VKORG <> '1000')`,
        FINCJSALESORG: `(VKORG <> '1000')`,
        IHSALESORG: `(VKORG <> '1000')`,
        OPENAR: `(VKORG <> '1000')`,
        OPENARSALESORG: `(VKORG <> '1000')`,
        CUSTOMERMASTER: `(VKORG <> '1000')`,
        CMSALESORG: `(VKORG <> '1000')`,
        SHIPPINGHISTORY: `(VKORG <> '1000')`,
        SHVKORG: `(VKORG <> '1000')`,
        PRICING: `(VKORG <> '1000')`,
        PRICINGSALESORG: `(VKORG <> '1000')`,
        OOVKORG: `(VKORG <> '1000')`,
        BOVKORG: `(VKORG <> '1000')`,
        INVOICEHISTORY: `(VKORG <> '1000' AND WERKS <> '1010')`,
        OPENORDERS: `(VKORG <> '1000' AND PLANT <> '1010')`,
        BACKORDERS: `(VKORG <> '1000' AND PLANT <> '1010')`,
        RETURNS: `(CO_VKORG <> '1000' AND PLANT <> '1010')`,
        SHIPPINGSTATUS: `(VKORG <> '1000' AND WAREHOUSE_NAME_LNUMT <> '1010')`,
        SHIPSTATUSVKORG: `(VKORG <> '1000')`
    };
    
    /**
     * Entity → Filter map for manufacturer 0001000005
     * (Sales Org 1000 excluded ONLY, allow Plant 1010)
     */
    const entityFilterMapFor0001000005 = {
        SALESBYCURRENT: `(CO_VKORG <> '1000')`,
        SALESBYCURRENTWOPID: `(CO_VKORG <> '1000')`,
        SBCSALESORG: `(CO_VKORG <> '1000')`,
        RETVKORG: `(CO_VKORG <> '1000')`,
        ITEMMASTER: `(SALESORG <> '1000')`,
        ITEMMASSALESORG: `(SALESORG <> '1000')`,
        INVENTORYSTATUS: `(VKBUR <> '1000')`,
        INVSTATUSVKBUR: `(VKBUR <> '1000')`,
        INVENTORYBYLOT: `(VKBUR <> '1000')`,
        INVENTORYVALUATION: `(VKBUR <> '1000')`,
        INVENTORYAUDITTRAIL: `(SALES_ORG <> '1000')`,
        IATSALESORG: `(SALES_ORG <> '1000')`,
        CASHJOURNAL: `(VKORG <> '1000')`,
        INVENTORYSNAPSHOT: `(VKORG <> '1000')`,
        FINCJSALESORG: `(VKORG <> '1000')`,
        IHSALESORG: `(VKORG <> '1000')`,
        OPENAR: `(VKORG <> '1000')`,
        OPENARSALESORG: `(VKORG <> '1000')`,
        CUSTOMERMASTER: `(VKORG <> '1000')`,
        CMSALESORG: `(VKORG <> '1000')`,
        SHIPPINGHISTORY: `(VKORG <> '1000')`,
        SHVKORG: `(VKORG <> '1000')`,
        PRICING: `(VKORG <> '1000')`,
        PRICINGSALESORG: `(VKORG <> '1000')`,
        OOVKORG: `(VKORG <> '1000')`,
        BOVKORG: `(VKORG <> '1000')`,
        INVOICEHISTORY: `(VKORG <> '1000')`,
        OPENORDERS: `(VKORG <> '1000')`,
        BACKORDERS: `(VKORG <> '1000')`,
        RETURNS: `(CO_VKORG <> '1000')`,
        SHIPPINGSTATUS: `(VKORG <> '1000')`,
        SHIPSTATUSVKORG: `(VKORG <> '1000')`,
        MAINPAGESUMMARY: `(VKORG <> '1000')`,
        MAINPAGEINVENTORY: `(VKORG <> '1000')`
    };
    const excludedSKUsFor0001000005 = {
        SALESBYCURRENT: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        SALESBYCURRENTWOPID: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        ITEMMASTER: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        INVENTORYSTATUS: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        INVENTORYBYLOT: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        INVENTORYVALUATION: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        INVENTORYAUDITTRAIL:['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'], 
        INVENTORYSNAPSHOT: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        PRICING: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        OPENORDERS: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        BACKORDERS: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        SHIPPINGSTATUS: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
        MAINPAGEINVENTORY: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062']
    };
    const skuFieldMap = {
        SALESBYCURRENT: 'SKU_MATNR',
        SALESBYCURRENTWOPID: 'SKU_MATNR',
        ITEMMASTER: 'PRODUCT',
        INVENTORYSTATUS: 'SKU_MATNR',
        INVENTORYBYLOT: 'MATNR',
        INVENTORYVALUATION: 'MATNR',
        INVENTORYAUDITTRAIL:'MATNR', 
        INVENTORYSNAPSHOT: 'MATNR',
        PRICING: 'MATNR',
        OPENORDERS: 'MATNR',
        BACKORDERS: 'MATNR',
        SHIPPINGSTATUS: 'OBD_ITEM_NO_ITEMNO ',
        MAINPAGEINVENTORY: 'SKU_MATNR'
    };
    /**
     * Manufacturer → Entity Filter Map
     */
    const manufacturerFilterMap = {
        '0001000019': entityFilterMapFor0001000019
    };
    
    // --- Generic 'before READ' Handler ---
    this.before('READ', (req) => {
        const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
        const fullEntityName = req.target?.name;
        const entityName = fullEntityName?.split('.').pop();

        console.log(`READ handler for ${entityName} - ManufacturerNumber: ${userManufacturer}`);

        // 🎯 SKU-based filtering for 0001000005
        if (userManufacturer === '0001000005') {
            const excludedSKUs = excludedSKUsFor0001000005[entityName];
            const skuField = skuFieldMap[entityName];

            if (excludedSKUs?.length && skuField) {
                const skuFilter = `${skuField} NOT IN (${excludedSKUs.map(sku => `'${sku}'`).join(', ')})`;
                console.log(`Applying SKU exclusion filter for manufacturer 0001000005 on entity ${entityName}: ${skuFilter}`);
                try {
                    req.query.where(skuFilter);
                } catch (e) {
                    console.warn(`Entity ${entityName} does not support filtering`);
                }
                return; // ✅ early return — skip VKORG-based filter
            }
        }

        // 🧾 VKORG-based filtering for 0001000019 and others in the map
        const entityFilters = manufacturerFilterMap[userManufacturer];
        const filter = entityFilters?.[entityName];

        if (filter) {
            console.log(`Applying VKORG exclusion filter for manufacturer ${userManufacturer} on entity: ${entityName}`);
            try {
                req.query.where(filter);
            } catch (e) {
                console.warn(`Entity ${entityName} does not support filtering`);
            }
        }
    });
    /**
     * This 'before READ' handler applies additional query filters for SALESBYCURRENT
     * based on user ManufacturerNumber.
     */
    // this.before('READ', ['SALESBYCURRENT', 'SALESBYCURRENTWOPID'], async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`SALESBYCURRENT READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(CO_VKORG <> '1000' AND WERKS <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });
    // this.before('READ', ['SBCSALESORG', 'RETVKORG'], async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`SBCSALESORG READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(CO_VKORG <> '1000')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // /**
    //  * This 'before READ' handler applies additional query filters for ITEMMASTER
    //  * based on user ManufacturerNumber.
    //  */
    // this.before('READ', 'ITEMMASTER', async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`ITEMMAS READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(SALESORG <> '1000' AND BWKEY <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', 'ITEMMASSALESORG', async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`ITEMMASSALESORG READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(SALESORG <> '1000')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', ['INVENTORYSTATUS', 'INVENTORYBYLOT', 'INVENTORYVALUATION'], async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`INVENTORYSTATUS READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(VKBUR <> '1000' AND PLANT <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', ['INVSTATUSVKBUR', 'INVENTORYBYLOT', 'INVENTORYVALUATION'], async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`INVSTATUSVKBUR READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(VKBUR <> '1000')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', 'INVENTORYAUDITTRAIL', async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`INVENTORYAUDITTRAIL READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(SALES_ORG <> '1000' AND WERKS <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', 'IATSALESORG', async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`IATSALESORG READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(SALES_ORG <> '1000' AND WERKS <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', [
    //     'CASHJOURNAL', 
    //     'INVENTORYSNAPSHOT', 
    //     'FINCJSALESORG', 
    //     'IHSALESORG', 
    //     'OPENAR', 
    //     'OPENARSALESORG', 
    //     'CUSTOMERMASTER',
    //     'CMSALESORG',
    //     'SHIPPINGHISTORY',
    //     'SHVKORG',
    //     'PRICING',
    //     'PRICINGSALESORG',
    //     'OOVKORG',
    //     'BOVKORG'
    // ], async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`CASHJOURNAL READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(VKORG <> '1000')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', ['INVOICEHISTORY', 'INVENTORYSNAPSHOT'], async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`INVOICEHISTORY READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(VKORG <> '1000' AND WERKS <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', ['OPENORDERS', 'BACKORDERS'], async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`OPENORDERS READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(VKORG <> '1000' AND PLANT <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });

    // this.before('READ', 'RETURNS', async (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     console.log(`SALESBYCURRENT READ handler - ManufacturerNumber: ${userManufacturer}`);

    //     if (userManufacturer === '0001000019') {
    //         console.log(`Applying exclusion filter for user 0001000019 on SALESBYCURRENT`);

    //         try {
    //             req.query.where(`(CO_VKORG <> '1000' AND PLANT <> '1010')`);
    //         } catch (e) {
    //             console.warn(`Entity ${req.target.name} does not support SalesOrg/Plant filtering`);
    //         }
    //     }
    // });
    // this.before('READ', 'INVSTATUSPRODUCTCODE', (req) => {

    //     // Check if internal user (replace with your real role check!)
    //     const isInternal = req.user.is('Internal')

    //     if (isInternal) {
    //         console.log('Applying deduplication for Internal user')

    //         // Override query: only select distinct PRODUCT_CODE (no MFRNR)
    //         req.query.SELECT.columns = [
    //             { ref: ['PRODUCT_CODE'] }
    //         ]

    //         // Optional: for safety, add groupBy (depending on DB version)
    //         req.query.SELECT.groupBy = [
    //             { ref: ['PRODUCT_CODE'] }
    //         ]
    //     }
    // });

    // --- START: Deduplication for Internal users ---

    // Config: entity name => column to deduplicate on
    const dedupConfig = {
        'ITEMMASPD': 'PRODUCTDESCRIPTION_EN',
        'ITEMMASP': 'PRODUCT',
        'ITEMMASMFRNRNAME': 'MFRNR_NAME',
        'ITEMMASPSID': 'MFRNR_PART_NUMBER', 
        'ITEMMASCATEGORY': 'CATEGORY',
        'ITEMMASSALESORG': 'SALESORG',
        'INVSTATUSMFRNRNAME': 'MFRNR_NAME',
        'INVSTATUSPRODUCTCODE': 'PRODUCT_CODE',
        'INVSTATUSVKBUR': 'VKBUR',
        'INVSTATUSPLANTNAME': 'PLANT_NAME',
        'IATPLANTNAME': 'PLANT_NAME',
        'IATTRANTYPE': 'TRAN_TYPE',
        'IATPRODUCTCODE': 'MFRNR_PROD_CODE',
        'IATLOT': 'CHARG',
        'IATSALESORG': 'SALES_ORG',
        'IATWAREHOUSE': 'WAREHOUSE_STATUS',
        'IATCUSTSUPP': 'KUNNR',
        'IATCUSTSUPPNAME': 'CUSTOMER_NAME',
        'IATMFRNRNAME': 'MFRNR_NAME',
        'BLARTS': 'BLART',
        'BILL_TOS': 'BILL_TO',
        'BILL_TONAME': 'NAME1',
        'FINCJMFRNRNAME': 'MFRNR_NAME',
        'FINCJPRCTR': 'PRCTR',
        'FINCJSALESORG': 'VKORG',
        'INVSNAPPLANTNAME': 'PLANT_NAME',
        'INVSNAPPROD': 'MFRPN',
        'INVSNAPPRODSKU': 'MATNR',
        'INVSNAPPRODDESC': 'MAKTX',
        'INVSNAPLOT': 'CHARG',
        'INVSNAPWARESTAT': 'WAREHOUSE_STATUS',
        'INVSNAPMFRNRNAME': 'MFRNR_NAME',
        'INVSNAPVKORG': 'VKORG',
        'INVBYLOTPLANTNAME': 'PLANT_NAME',
        'INVBYLOTPRODUCTCODE': 'MFRPN',
        'INVBYLOTLOT': 'CHARG',
        'INVBYLOTWAREHOUSE': 'WAREHOUSE_STATUS',
        'INVBYLOTMFRNRNAME': 'MFRNR_NAME',
        'INVBYLOTVKBUR': 'VKBUR',
        'OPENARCUSTOMER': 'NAME1',
        'OPENARCUSTOMERID': 'BILL_TO',
        'OPENARMFRNRNAME': 'MFRNR_NAME',
        'OPENARSALESORG': 'VKORG',
        'INVVALPLANTNAME': 'PLANT_NAME',
        'INVVALPROD': 'MFRPN',
        'INVVALPRODDESC': 'MAKTX',
        'INVVALPRODSKU': 'MATNR',
        'INVVALMFRNRNAME': 'MFRNR_NAME',
        'INVVALVKBUR': 'VKBUR',
        'IHPLANTNAME': 'PLANT_NAME',
        'IHCUSTOMER': 'NAME1',
        'IHSHIPTO': 'SHIP_TO',
        'IHBEZEI': 'BEZEI',
        'IHINVOICE': 'VBELN',
        'IHPO': 'BSTKD',
        'IHTYPE': 'ORDER_TYPE',
        'IHPROVINCE': 'REGIO',
        'IHMFRNRNAME': 'MFRNR_NAME',
        'IHSALESORG': 'VKORG',
        'SBCINVOICE': 'INVOICE_CREDIT_VBELN',
        'SBCBEZEI': 'BEZEI',
        'SBCBEZEIAUART': 'BEZEI_AUART',
        'SBCPLANTNAME': 'PLANT_NAME',
        'SBCPRODDESC': 'PRODUCT_DESCRIPTION_MAKTX',
        'SBCTYPE': 'VTEXT_FKART',
        'SBCWAREHOUSE': 'WAREHOUSE',
        'SBCLOT': 'LOT_CHARG',
        'SBCBILLTO': 'BILL_TO_NAME',
        'SBCBILLTOID': 'BILL_TO_KUNRE_ANA',
        'SBCSHIPTOID': 'SHIP_TO_KUNWE_ANA',
        'SBCSHIPTO': 'SHIP_TO_NAME',
        'SBCMFRNRNAME': 'MFRNR_NAME',
        'SBCSALESORG': 'CO_VKORG',
        'SBCSALESOFFICE': 'VKBUR',
        'SBCYEAR': 'INV_YEAR',
        'KUNN2_BILLTO': 'KUNN2_BILLTO',
        'KUNN2_BILLTONAME': 'NAME1_BILLTO',
        'KUNN2_SHIPTO': 'KUNN2_SHIPTO',
        'KUNN2_SHIPTONAME': 'NAME1_SHIPTO',
        'CAL_CUST_STATUS': 'CAL_CUST_STATUS',
        'CMSALESORG': 'VKORG',
        'SHINVOICE': 'KUNAG',
        'SHSHIPTO': 'KUNNR',
        'SHSHIPTONAME': 'NAME1',
        'SHCARRIER': 'CARRIER',
        'SHTRACKING': 'TRACKN',
        'SHMFRNRNAME': 'MFRNR_NAME',
        'SHVKORG': 'VKORG',
        'PRICINGPRICEDESC': 'VTEXT',
        'PRICINGPRODUCTDESC': 'MAKTX',
        'PRICINGPRODUCT': 'MATNR',
        'PRICINGMFRNRNAME': 'MFRNR_NAME',
        'PRICINGSALESORG': 'VKORG',
        'OOVBELN': 'VBELN',
        'OOPRODDESC': 'MAKTX',
        'OOPROD': 'MATNR',
        'OOCUST': 'KUNNR',
        'OOSHIPTO': 'KUNWE_ANA',
        'OOSHIPTONAME': 'CAL_NAME',
        'OOPROVINCE': 'REGIO',
        'OOVKORG': 'VKORG',
        'OOMFRNRNAME': 'MFRNR_NAME',
        'RETCUST': 'CUSTOMER_KUNNR',
        'RETCUSTNAME': 'CUSTOMER_NAME_NAME1',
        'RETREASON': 'REASON_BEZEI',
        'RETRGA': 'VBELN_VBAK',
        'RETVKORG': 'CO_VKORG',
        'RETMFRNRNAME': 'MFRNR_NAME',
        'RETVKBUR': 'VKBUR',
        'BOPRODUCTDESC': 'MAKTX',
        'BOPRODUCT': 'MATNR',
        'BOBILLTO': 'KUNRE_ANA',
        'BOSHIPTO': 'KUNWE_ANA',
        'BOSHIPTONAME': 'NAME1',
        'BOMFRNRNAME': 'MFRNR_NAME',
        'BOVKORG': 'VKORG',
        'MPSYEAR': 'CALYEAR',
        'MPSMONTH': 'MONTH_NAME',
        "SHIPSTATUSSKU": "OBD_ITEM_NO_ITEMNO",
        "SHIPSTATUSCUSTPO": "CUSTOMER_PO_BSTNK",
        "SHIPSTATUSPRODDESC": "PRODUCT_DESCRIPTION_MAKTX",
        "SHIPSTATUSWHSTATUS": "PICK_AND_PACK_STATUS_SALES_SHIPPING_STATUS",
        "SHIPSTATUSVKORG": "VKORG",
        "SHIPSTATUSMFRNRNAME": "MANUFACTURER_NAME_MC_NAME1"
        // Add more here easily:
        // 'ANOTHERENTITY': 'ANOTHERCOLUMN'
    };

    // Apply deduplication before READ for configured entities
    this.before('READ', (req) => {
        const fullEntityName = req.target?.name;
        const entityName = fullEntityName?.split('.').pop();
    
        console.log(`[Deduplication] Incoming entity: '${fullEntityName}', stripped to: '${entityName}'`);
    
        const columnName = dedupConfig[entityName];
    
        if (!columnName) {
            console.log(`[Deduplication] No dedup config for entity '${entityName}'`);
            return;
        }
    
        deduplicateForInternal(req, columnName);
    });

    // this.before('READ', 'MediaFile', (data, req) => {
    //     // If no data or not an array (e.g., single result, already handled or error), return as is.
    //     if (!Array.isArray(data)) {
    //         console.log('[MediaFile] Data is not an array or is null/undefined. Returning as is.');
    //         return data;
    //     }

    //     // Check if the user is an internal user.
    //     const isInternalUser = req.user.is('Internal');

    //     // If there's only one result, or if it's not an internal user, pass through.
    //     if (data.length === 1 || !isInternalUser) {
    //         console.log(`[MediaFile] Single result found or not an Internal user (${isInternalUser}). Returning as is.`);
    //         return data;
    //     }

    //     // Fallback case for Internal users when multiple results are found
    //     console.log('[MediaFile] Multiple results found for Internal user, applying fallback.');
    //     return [{
    //         ID: 'fallback-id',
    //         MFGName: "Internal User",
    //         url: null, // Make sure this path is served publicly
    //         fileName: null,
    //         manufacturerNumber: null,
    //         mediaType: null,
    //         content: null,
    //         createdAt: null,
    //         modifiedAt: null,
    //         createdBy: null,
    //         modifiedBy: null
    //     }];
    // });
    
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

    this.on('READ', 'MediaFile', async (req, next) => {
        const user = req.user;

        // define internal user detection logic
        const isInternal = req.user.is('Internal')

        if (isInternal) {
            // Option 1: hard reject
            //req.reject(403, 'Internal users cannot list all manufacturers. Showing fallback instead.');

            //Option 2: return a fallback instead of rejecting
            return [{
                        MFGName: "McKesson Canada"
                    }];

            // just comment/uncomment which strategy you want
            //return;
        }
        return next();

        
    });
    // 3. Apply the handler to all 'READ' operations for the specified entities.
    this.after('READ', entitiesWithRoleBasedMfrnr, addRoleBasedVisibilityFlag);

    // --- END: Refactored logic ---
    // this.on('calculateOverallTotals', async (req) => {
    //     // Access the filters applied to the SalesAnalytics entity from the UI.
    //     // The req.query.SELECT.where clause will contain the filters from the SmartTable/SmartFilterBar.
    //     const filterClause = req.query.SELECT.where;

    //     // Build a CQN query to perform aggregations on the original SALESBYCURRENT table,
    //     // applying the same filters as the main table display.
    //     const cqn = SELECT.one`
    //         sum(AMOUNT_NETWR) as salesTotal,
    //         count(*) as lineCount,
    //         sum(QUANTITY_FKIMG) as unitsTotal,
    //         sum(QUANTITY_FKIMG) as quantityTotal,
    //         count(distinct case when VTEXT_FKART = 'Invoice' then INVOICE_CREDIT_VBELN end) as uniqueInvoiceCount
    //     `.from('SALESBYCURRENT'); // Query the original entity for overall totals

    //     // Apply the filters if they exist in the request.
    //     if (filterClause) {
    //         cqn.where(filterClause);
    //     }

    //     try {
    //         // Execute the query against the database
    //         const result = await cds.run(cqn);

    //         // Return the aggregated values. Use fallback to 0 for null results.
    //         return {
    //             salesTotal: result.salesTotal || 0,
    //             lineCount: result.lineCount || 0,
    //             unitsTotal: result.unitsTotal || 0,
    //             quantityTotal: result.quantityTotal || 0,
    //             uniqueInvoiceCount: result.uniqueInvoiceCount || 0,
    //         };
    //     } catch (error) {
    //         console.error("Error calculating overall totals:", error);
    //         // Re-throw the error or return default values if calculation fails
    //         throw new Error("Failed to calculate overall totals.");
    //     }
    // });
    

    
    //You can add other handlers for other entities or operations (CREATE, UPDATE, etc.) here.
});
