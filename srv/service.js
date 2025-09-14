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
      SALESBYCURRENTAPP: `(CO_VKORG <> '1000' AND WERKS <> '1010')`,
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
  
  // --- Mappings of entity to filters ---
    /**
     * Entity → Filter map for manufacturer 0001000002(Novartis)
     * (Sales Org 1000 and Plant 1000 excluded)
    */
    const entityFilterMapFor0001000002 = {
      SALESBYCURRENTAPP: `(CO_VKORG <> '1000' AND WERKS <> '1000')`,
      SALESBYCURRENTWOPID: `(CO_VKORG <> '1000' AND WERKS <> '1000')`,
      SBCSALESORG: `(CO_VKORG <> '1000')`,
      RETVKORG: `(CO_VKORG <> '1000')`,
      ITEMMASTER: `(SALESORG <> '1000' AND BWKEY <> '1000')`,
      ITEMMASSALESORG: `(SALESORG <> '1000')`,
      INVENTORYSTATUS: `(VKBUR <> '1000' AND PLANT <> '1000')`,
      INVSTATUSVKBUR: `(VKBUR <> '1000')`,
      INVENTORYBYLOT: `(VKBUR <> '1000' AND PLANT <> '1000')`,
      INVENTORYVALUATION: `(VKBUR <> '1000' AND PLANT <> '1000')`,
      INVENTORYAUDITTRAIL: `(SALES_ORG <> '1000' AND WERKS <> '1000')`,
      IATSALESORG: `(SALES_ORG <> '1000' AND WERKS <> '1000')`,
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
      INVOICEHISTORY: `(VKORG <> '1000' AND WERKS <> '1000')`,
      OPENORDERS: `(VKORG <> '1000' AND PLANT <> '1000')`,
      BACKORDERS: `(VKORG <> '1000' AND PLANT <> '1000')`,
      RETURNS: `(CO_VKORG <> '1000' AND PLANT <> '1000')`,
      SHIPPINGSTATUS: `(VKORG <> '1000' AND WAREHOUSE_NAME_LNUMT <> '1000')`,
      SHIPSTATUSVKORG: `(VKORG <> '1000')`
  };

  /**
   * Entity → Filter map for manufacturer 0001000005
   * (Sales Org 1000 excluded ONLY, allow Plant 1010)
   */
  const salesOrg1000ExclusionMap = {
      SALESBYCURRENTAPP: `(CO_VKORG <> '1000')`,
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
      SALESBYCURRENTAPP: ['1000025', '1000026', '1000035', '1000036', '1000037', '1000055', '1000056', '1000062'],
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
      SALESBYCURRENTAPP: 'SKU_MATNR',
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
      '0001000019': entityFilterMapFor0001000019,
      '0001000005': salesOrg1000ExclusionMap,
      '0001000002': entityFilterMapFor0001000002,  
      '0001000059': salesOrg1000ExclusionMap  
      // add more if needed
  };

  const fuzzySearchEntities = new Set([
      'ITEMMASTER',
      'ITEMMASPD',
      'ITEMMASMFRNRNAME',
      'ITEMMASCATEGORY',
      'INVENTORYSTATUS',
      'INVSTATUSPLANTNAME',
      'INVSTATUSMFRNRNAME',
      'INVENTORYAUDITTRAIL',
      'IATPLANTNAME',
      'IATTRANTYPE',
      'IATPRODUCTCODE',
      'IATLOT',
      'IATWAREHOUSE',
      'IATCUSTSUPPNAME',
      'IATMFRNRNAME',
      'BILL_TONAME',
      'FINCJMFRNRNAME',
      'INVENTORYSNAPSHOT',
      'INVSNAPPLANTNAME',
      'INVSNAPPRODDESC',
      'INVSNAPLOT',
      'INVSNAPWARESTAT',
      'INVSNAPMFRNRNAME',
      'INVENTORYBYLOT',
      'INVBYLOTPLANTNAME',
      'INVBYLOTPRODUCTCODE',
      'INVBYLOTLOT',
      'INVBYLOTWAREHOUSE',
      'INVBYLOTMFRNRNAME',
      'OPENAR',
      'OPENARCUSTOMER',
      'OPENARMFRNRNAME',
      'INVENTORYVALUATION',
      'INVVALPLANTNAME',
      'INVVALPRODDESC',
      'INVVALMFRNRNAME',
      'INVOICEHISTORY',
      'IHPLANTNAME',
      'IHCUSTOMER',
      'IHTYPE',
      'IHPROVINCE',
      'IHMFRNRNAME',
      'SALESBYCURRENTAPP',
      'SALESBYCURRENTWOPID',
      'SBCPRODDESC',
      'SBCBILLTO',
      'SBCSHIPTO',
      'SBCMFRNRNAME',
      'CUSTOMERMASTER',
      'KUNN2_BILLTONAME',
      'KUNN2_SHIPTONAME',
      'CAL_CUST_STATUS',
      'SHIPPINGHISTORY',
      'SHSHIPTONAME',
      'SHCARRIER',
      'SHMFRNRNAME',
      'PRICING',
      'PRICINGPRICEDESC',
      'PRICINGPRODUCTDESC',
      'PRICINGMFRNRNAME',
      'RETURNS',
      'RETCUSTNAME',
      'RETREASON',
      'RETMFRNRNAME',
      'BACKORDERS',
      'BOPRODUCTDESC',
      'BOSHIPTONAME',
      'BOMFRNRNAME',
      'SHIPPINGSTATUS',
      'SHIPSTATUSPRODDESC',
      'SHIPSTATUSWHSTATUS',
      'SHIPSTATUSMFRNRNAME',
      'MAINPAGESUMMARY',
      'MPSMONTH'
    ]);
    // Map of fields to exclude from fuzzy LIKE per entity
    const fuzzyExclusions = {
      SALESBYCURRENTAPP: ['CURRENT'],
      SALESBYCURRENTWOPID: ['CURRENT'],
      INVOICEHISTORY: ['CURRENT'],
      INVENTORYAUDITTRAIL: ['CURRENT'],
      INVENTORYSNAPSHOT: ['CURRENT'],
      RETURNS: ['CURRENT'],
      SHIPPINGHISTORY: ['CURRENT']
      // Add other entity → field exclusions here
    };

    // Helper: is the element a string-ish field we can safely fuzzy on?
    function isStringField(req, field) {
      const el = req.target?.elements?.[field];
      const t = el?.type;
      // Treat these as strings; adjust if you use custom types
      return t === 'cds.String' || t === 'cds.LargeString' || t === 'cds.UUID' || t === 'Edm.String';
    }

    this.before('READ', async (req) => {
      const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
      const fullEntityName = req.target?.name;
      const entityName = fullEntityName?.split('.').pop();

      console.log(`📥 READ request on ${entityName}, Manufacturer: ${userManufacturer}`);

      let where = req.query.SELECT.where ? [...req.query.SELECT.where] : [];

      // === 1) SKU-based exclusion for manufacturer 0001000005 ===
      if (userManufacturer === '0001000005') {
        const excludedSKUs = excludedSKUsFor0001000005[entityName];
        const skuField = skuFieldMap[entityName];

        if (excludedSKUs?.length && skuField) {
          const skuFilter = {
            xpr: [
              { ref: [skuField] },
              'not in',
              { val: excludedSKUs }
            ]
          };
          console.log(`🧹 SKU Filter for ${entityName}:`, skuFilter);
          if (where.length > 0) where.push('and');
          where.push(skuFilter);
        }
      }

      // === 2) VKORG/PLANT-based filter per manufacturer/entity ===
      const entityFilters = manufacturerFilterMap[userManufacturer];
      const rawFilter = entityFilters?.[entityName];

      if (rawFilter) {
        try {
          const parsedExpr = cds.parse.expr(rawFilter);
          console.log(`🔒 VKORG Filter for ${entityName}:`, rawFilter);
          if (where.length > 0) where.push('and');
          where.push(parsedExpr);
        } catch (e) {
          console.warn(`⚠️ Failed to parse VKORG filter for ${entityName}: ${e.message}`);
        }
      }

      // === 3) Fuzzy transformation (data-type-safe + per-field exclusions) ===
      if (fuzzySearchEntities.has(entityName) && where.length) {
        const transformed = [];
        const exclusions = new Set(fuzzyExclusions[entityName] || []);

        for (let i = 0; i < where.length; i++) {
          const tok = where[i];

          // copy logical connectors and parentheses
          if (typeof tok === 'string' && (tok === 'and' || tok === 'or' || tok === '(' || tok === ')')) {
            transformed.push(tok);
            continue;
          }

          // preserve complex/nested expressions as-is
          if (tok?.xpr) {
            transformed.push(tok);
            continue;
          }

          // Handle [ref, operator, value] triples
          if (tok?.ref) {
            const field = tok.ref[0];
            const op = where[i + 1];
            const rhs = where[i + 2];

            // If looks like a proper triple, decide to transform or copy
            if (typeof op === 'string' && rhs !== undefined) {
              const isEq = (op === '=' || op === 'eq');
              const rhsIsVal = typeof rhs === 'object' && rhs !== null && ('val' in rhs);

              // Only transform: equality + string field + not excluded + RHS is a literal value
              if (isEq && rhsIsVal && isStringField(req, field) && !exclusions.has(field)) {
                const upperVal = String(rhs.val).toUpperCase();
                // Use 'upper' which compiles cleanly to SQL UPPER(...)
                transformed.push(
                  { func: 'upper', args: [{ ref: [field] }] },
                  'like',
                  { val: `%${upperVal}%` }
                );
                i += 2; // consumed op + rhs
                continue;
              }

              // ✅ Default: copy the triple untouched
              transformed.push(tok, op, rhs);
              i += 2;
              continue;
            }

            // Not a standard triple → copy token
            transformed.push(tok);
            continue;
          }

          // Fallback: copy anything else verbatim
          transformed.push(tok);
        }

        req.query.SELECT.where = transformed;
        console.log(`🔍 Final WHERE (fuzzy, safe) for ${entityName}:`, JSON.stringify(transformed, null, 2));
      } else if (where.length) {
        req.query.SELECT.where = where;
        console.log(`📄 Final WHERE (no fuzzy) for ${entityName}:`, JSON.stringify(where, null, 2));
      }
    });
    // // --- Generic 'before READ' Handler ---
    // this.before('READ', (req) => {
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    //     const fullEntityName = req.target?.name;
    //     const entityName = fullEntityName?.split('.').pop();

    //     console.log(`READ handler for ${entityName} - ManufacturerNumber: ${userManufacturer}`);

    //     // 🎯 SKU-based filtering for 0001000005
    //     if (userManufacturer === '0001000005') {
    //         const excludedSKUs = excludedSKUsFor0001000005[entityName];
    //         const skuField = skuFieldMap[entityName];

    //         if (excludedSKUs?.length && skuField) {
    //             const skuFilter = `${skuField} NOT IN (${excludedSKUs.map(sku => `'${sku}'`).join(', ')})`;
    //             console.log(`Applying SKU exclusion filter for manufacturer 0001000005 on entity ${entityName}: ${skuFilter}`);
    //             try {
    //                 req.query.where(skuFilter);
    //             } catch (e) {
    //                 console.warn(`Entity ${entityName} does not support filtering`);
    //             }
    //             return; // ✅ early return — skip VKORG-based filter
    //         }
    //     }

    //     // 🧾 VKORG-based filtering for 0001000019 and others in the map
    //     const entityFilters = manufacturerFilterMap[userManufacturer];
    //     const filter = entityFilters?.[entityName];

    //     if (filter) {
    //         console.log(`Applying VKORG exclusion filter for manufacturer ${userManufacturer} on entity: ${entityName}`);
    //         try {
    //             req.query.where(filter);
    //         } catch (e) {
    //             console.warn(`Entity ${entityName} does not support filtering`);
    //         }
    //     }
    // });
    // this.before ('READ', [
    //     'ITEMMASTER',
    //     'ITEMMASPD',
    //     'ITEMMASMFRNRNAME',
    //     'ITEMMASCATEGORY',
    //     'INVENTORYSTATUS',
    //     'INVSTATUSPLANTNAME',
    //     'INVSTATUSMFRNRNAME',
    //     'INVENTORYAUDITTRAIL',
    //     'IATPLANTNAME',
    //     'IATTRANTYPE',
    //     'IATPRODUCTCODE',
    //     'IATLOT',
    //     'IATWAREHOUSE',
    //     'IATCUSTSUPPNAME',
    //     'IATMFRNRNAME',
    //     'BILL_TONAME',
    //     'FINCJMFRNRNAME',
    //     'INVENTORYSNAPSHOT',
    //     'INVSNAPPLANTNAME',
    //     'INVSNAPPRODDESC',
    //     'INVSNAPLOT',
    //     'INVSNAPWARESTAT',
    //     'INVSNAPMFRNRNAME',
    //     'INVENTORYBYLOT',
    //     'INVBYLOTPLANTNAME',
    //     'INVBYLOTPRODUCTCODE',
    //     'INVBYLOTLOT',
    //     'INVBYLOTWAREHOUSE',
    //     'INVBYLOTMFRNRNAME',
    //     'OPENAR',
    //     'OPENARCUSTOMER',
    //     'OPENARMFRNRNAME',
    //     'INVENTORYVALUATION',
    //     'INVVALPLANTNAME',
    //     'INVVALPRODDESC',
    //     'INVVALMFRNRNAME',
    //     'INVOICEHISTORY',
    //     'IHPLANTNAME',
    //     'IHCUSTOMER',
    //     'IHTYPE',
    //     'IHPROVINCE',
    //     'IHMFRNRNAME',
    //     //'SALESBYCURRENT',
    //     //'SALESBYCURRENTWOPID',
    //     'SBCPRODDESC',
    //     'SBCBILLTO',
    //     'SBCSHIPTO',
    //     'SBCMFRNRNAME',
    //     'CUSTOMERMASTER',
    //     'KUNN2_BILLTONAME',
    //     'KUNN2_SHIPTONAME',
    //     'CAL_CUST_STATUS',
    //     'SHIPPINGHISTORY',
    //     'SHSHIPTONAME',
    //     'SHCARRIER',
    //     'SHMFRNRNAME',
    //     'PRICING',
    //     'PRICINGPRICEDESC',
    //     'PRICINGPRODUCTDESC',
    //     'PRICINGMFRNRNAME',
    //     'RETURNS',
    //     'RETCUSTNAME',
    //     'RETREASON',
    //     'RETMFRNRNAME',
    //     'BACKORDERS',
    //     'BOPRODUCTDESC',
    //     'BOSHIPTONAME',
    //     'BOMFRNRNAME',
    //     'SHIPPINGSTATUS',
    //     'SHIPSTATUSPRODDESC',
    //     'SHIPSTATUSWHSTATUS',
    //     'SHIPSTATUSMFRNRNAME'
    // ], async (req) => {
    
    //     console.log("before searching");
    //     console.log(req.query.SELECT.where);
    //     const existingConditions = req.query.SELECT.where ? [...req.query.SELECT.where] : [];
    //     const newCondition = [];
    //     existingConditions.forEach((condition, index) => {
    //         if (condition === 'and' || condition === 'or' || condition === '(' || condition === ')' || condition.func) {
    //             newCondition.push(condition);
    //         } else if (condition.ref) {
    //             const scol = condition.ref[0];
    //             const sOperator = existingConditions[index + 1];
    //             const sval = existingConditions[index + 2]?.val;
    //             // 🔥 Transform only normal "=" searches to LIKE
    //             if (sOperator === '=' && sval) {
    //                 newCondition.push(
    //                     { func: 'toupper', args: [{ ref: [scol] }] },
    //                     'like',
    //                     { val: `%${sval.toUpperCase()}%` }
    //                 );
    //             } else {
    //                 newCondition.push({ ref: [scol] }, sOperator, { val: sval });
    //             }
    //         }
    //     });

    //     if (newCondition.length > 0) {
    //         req.query.SELECT.where = newCondition;
    //     }
    //     console.log(req.query.SELECT.where);
    // });
    // this.before('READ', [
    //     'ITEMMASTER',
    //     'ITEMMASPD',
    //     'ITEMMASMFRNRNAME',
    //     'ITEMMASCATEGORY',
    //     'INVENTORYSTATUS',
    //     'INVSTATUSPLANTNAME',
    //     'INVSTATUSMFRNRNAME',
    //     'INVENTORYAUDITTRAIL',
    //     'IATPLANTNAME',
    //     'IATTRANTYPE',
    //     'IATPRODUCTCODE',
    //     'IATLOT',
    //     'IATWAREHOUSE',
    //     'IATCUSTSUPPNAME',
    //     'IATMFRNRNAME',
    //     'BILL_TONAME',
    //     'FINCJMFRNRNAME',
    //     'INVENTORYSNAPSHOT',
    //     'INVSNAPPLANTNAME',
    //     'INVSNAPPRODDESC',
    //     'INVSNAPLOT',
    //     'INVSNAPWARESTAT',
    //     'INVSNAPMFRNRNAME',
    //     'INVENTORYBYLOT',
    //     'INVBYLOTPLANTNAME',
    //     'INVBYLOTPRODUCTCODE',
    //     'INVBYLOTLOT',
    //     'INVBYLOTWAREHOUSE',
    //     'INVBYLOTMFRNRNAME',
    //     'OPENAR',
    //     'OPENARCUSTOMER',
    //     'OPENARMFRNRNAME',
    //     'INVENTORYVALUATION',
    //     'INVVALPLANTNAME',
    //     'INVVALPRODDESC',
    //     'INVVALMFRNRNAME',
    //     'INVOICEHISTORY',
    //     'IHPLANTNAME',
    //     'IHCUSTOMER',
    //     'IHTYPE',
    //     'IHPROVINCE',
    //     'IHMFRNRNAME',
    //     'SALESBYCURRENT', // <--- EXCLUDE SALESBYCURRENT FROM THIS GENERIC HANDLER
    //     'SALESBYCURRENTWOPID', // <--- EXCLUDE SALESBYCURRENTWOPID
    //     'SBCPRODDESC',
    //     'SBCBILLTO',
    //     'SBCSHIPTO',
    //     'SBCMFRNRNAME',
    //     'CUSTOMERMASTER',
    //     'KUNN2_BILLTONAME',
    //     'KUNN2_SHIPTONAME',
    //     'CAL_CUST_STATUS',
    //     'SHIPPINGHISTORY',
    //     'SHSHIPTONAME',
    //     'SHCARRIER',
    //     'SHMFRNRNAME',
    //     'PRICING',
    //     'PRICINGPRICEDESC',
    //     'PRICINGPRODUCTDESC',
    //     'PRICINGMFRNRNAME',
    //     'RETURNS',
    //     'RETCUSTNAME',
    //     'RETREASON',
    //     'RETMFRNRNAME',
    //     'BACKORDERS',
    //     'BOPRODUCTDESC',
    //     'BOSHIPTONAME',
    //     'BOMFRNRNAME',
    //     'SHIPPINGSTATUS',
    //     'SHIPSTATUSPRODDESC',
    //     'SHIPSTATUSWHSTATUS',
    //     'SHIPSTATUSMFRNRNAME'
    // ], async (req) => {
    //     console.log("before searching");
    //     console.log(req.query.SELECT.where);
    
    //     const fullEntityName = req.target?.name;
    //     const entityName = fullEntityName?.split('.').pop();
    //     const userManufacturer = req.user?.attr?.ManufacturerNumber?.[0];
    
    //     const existingConditions = req.query.SELECT.where ? [...req.query.SELECT.where] : [];
    //     const newCondition = [];
    
    //     // Check if the current entity/manufacturer combination has a specific filter
    //     // If so, we should not apply the generic toUpper/like transformation to its specific filter parts
    //     const hasSpecificManufacturerFilter = manufacturerFilterMap[userManufacturer] && manufacturerFilterMap[userManufacturer][entityName];
    
    //     existingConditions.forEach((condition, index) => {
    //         if (condition === 'and' || condition === 'or' || condition === '(' || condition === ')' || condition.func) {
    //             newCondition.push(condition);
    //         } else if (condition.ref) {
    //             const scol = condition.ref[0];
    //             const sOperator = existingConditions[index + 1];
    //             const sval = existingConditions[index + 2]?.val;
    
    //             // Check if this condition is part of a special filter (e.g., VKORG, WERKS for 0001000024)
    //             // You might need a more sophisticated way to identify these,
    //             // perhaps by maintaining a list of fields that should NOT be toupper/like'd
    //             // or by checking if the current condition matches a part of your pre-defined filters.
    //             // For simplicity, assuming 'CO_VKORG' and 'WERKS' are the problem fields for the special case.
    //             const isSpecialFilterField = (scol === 'CO_VKORG' || scol === 'WERKS' || scol === 'SALESORG' || scol === 'VKBUR' || scol === 'SALES_ORG' || scol === 'VKORG' || scol === 'WAREHOUSE_NAME_LNUMT');
    
    //             // If it's a direct equality on a potentially problematic field in a specific filter context,
    //             // or if the entity is SALESBYCURRENT (or others with hardcoded filters)
    //             // AND the manufacturer has a specific filter applied, then DO NOT apply toUpper/like.
    //             if (sOperator === '=' && sval && !isSpecialFilterField && !hasSpecificManufacturerFilter) {
    //                 // Apply toUpper and LIKE for general case-insensitive search
    //                 newCondition.push(
    //                     { func: 'toupper', args: [{ ref: [scol] }] },
    //                     'like',
    //                     { val: `%${sval.toUpperCase()}%` }
    //                 );
    //             } else {
    //                 // Push the condition as is if it's not a candidate for toUpper/like transformation,
    //                 // or if it's part of a special filter that should remain untouched.
    //                 newCondition.push({ ref: [scol] }, sOperator, { val: sval });
    //             }
    //         }
    //     });
    
    //     if (newCondition.length > 0) {
    //         req.query.SELECT.where = newCondition;
    //     }
    
    //     console.log(req.query.SELECT.where);
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
        'BILLINGTYPE': 'DOC_TYPE',
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
        'SBCCUSTOMERTYPE': 'BILL_TO_TYPE',
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
    this.before("READ", "MAINPAGESUMMARY", (req) => {
        if (req.data.CALYEAR && typeof req.data.CALYEAR === "string") {
          req.data.CALYEAR = parseInt(req.data.CALYEAR, 10);
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

    this.on('READ', 'MediaFile', async (req, next) => {
        
        const isAdmin = req.user.is('Admin');
        const isInternal = req.user.is('Internal') && !isAdmin;
        // If admin, do not apply fallback logic to avoid breaking UI
        if (isAdmin) {
          return next(); // Return real data only
        }
      
        let results = await next();
      
        if (isInternal) {
          console.log("Internal user detected — injecting fallback record");
      
          if (!Array.isArray(results)) results = [];
      
          results.unshift({
            ID: "be12312c-826f-4249-ab71-0823b1929824",
            MFGName: "McKesson",
            content: "image/jpeg",
            createdAt: new Date().toISOString(),
            createdBy: "system",
            fileName: "MCKCAN1.jpg",
            manufacturerNumber: "0002020000",
            mediaType: "image/jpeg",
            modifiedAt: new Date().toISOString(),
            modifiedBy: "system",
            url: "/fallback.jpg", // Or use static hosting
            IsActiveEntity: true,
            isFallbackStub: true
          });
        }
      
        return results;
      });

    // const OKTA_API_TOKEN = '00Rpkzmvl-3WrAG_z3FewYqZeKCzaSax09cF1NR5Ph';
    // const OKTA_API_URL = 'https://rbgcatman-auth-login.dev.mckesson.ca/api/v1/users?activate=true';
    
    // this.on('CreateUser', async (req) => {
    //     console.log("Action Hit!", req.data);
    //     try {
    //         const payload = req.data.input;
    
    //       // ✅ Build Okta User Creation Payload
    //         const oktaPayload = {
    //             profile: {
    //                 firstName: payload.firstName,
    //                 lastName: payload.lastName,
    //                 email: payload.email,
    //                 login: payload.login || payload.email,
    //                 SalesOffice: payload.salesOffice,
    //                 ProfitCentre: payload.profitCentre,
    //                 SalesOrg: payload.salesOrg,
    //                 ManufacturerNumber: payload.manufacturerNumbers,
    //                 MFGName: payload.mfgName
    //             },
    //             groupIds: payload.selectedGroup // Optional: populate if you want to assign Okta group IDs
    //         };
    
    //         // ✅ Call Okta API
    //         const response = await axios.post(OKTA_API_URL, oktaPayload, {
    //             headers: {
    //             Authorization: `SSWS ${OKTA_API_TOKEN}`,
    //             "Content-Type": "application/json"
    //             }
    //         });
    
    //         return {
    //             success: true,
    //             message: "User successfully created in Okta",
    //             userId: response.data.id
    //         };
    
    //     } catch (err) {
    //         console.error("Okta Error: ", err.response?.data || err.message);
    //         return {
    //             success: false,
    //             message: err.response?.data?.errorCauses?.[0]?.errorSummary || err.message,
    //             userId: ""
    //         };
    //     }
    // });
    // --- CASE-INSENSITIVE FILTERING LOGIC ---
    // this.on('READ', 'BOSHIPTONAME', async (req) => {
    //     // Get the entity reference for type safety and consistency
    //     const { BOSHIPTONAME } = this.entities; // Make sure this line is present and correct

    //     // Access the incoming query from the request
    //     const { SELECT } = req.query;

    //     // --- Step 1: Identify the fields that need case-insensitive filtering ---
    //     const caseInsensitiveFields = ['NAME1']; // Add all relevant fields here

    //     // --- Step 2: Traverse and modify the WHERE clause of the SELECT query ---
    //     if (SELECT.where) {
    //         // Pass cds.ql to the utility function
    //         SELECT.where = transformFilterToCaseInsensitive(SELECT.where, caseInsensitiveFields, cds.ql);
    //     }

    //     // --- Step 3: Execute the modified query ---
    //     // Let CAP execute the query against the database with the transformed WHERE clause
    //     return cds.run(SELECT);
    // });
    

    this.on('createOktaUser', async req => {
      const axios = require('axios');
      const user = req.data.user;
      const OKTA_API_TOKEN = process.env.OKTA_API_TOKEN;
      const OKTA_API_URL = process.env.OKTA_API_URL;

      if (!OKTA_API_TOKEN) {
          req.error(500, "OKTA_API_TOKEN is not set in environment variables.");
          return;
      }

      const payload = {
          profile: {
              firstName: user.profile?.firstName,
              lastName: user.profile?.lastName,
              email: user.profile?.email,
              login: user.profile?.email,
              salesOffice: user.profile?.salesOffice,
              profitCentre: user.profile?.profitCentre,
              salesOrg: user.profile?.salesOrg,
              manufacturerNumber: user.profile?.manufacturerNumber,
              mfgName: user.profile?.mfgName
          },
          groupIds: Array.isArray(user.groupIds)
              ? user.groupIds
              : [user.groupIds].filter(Boolean)
      };

      try {
          const response = await axios.post(
              `${OKTA_API_URL}users?activate=true`,
              payload,
              {
                  headers: {
                      'Authorization': `SSWS ${OKTA_API_TOKEN}`,
                      'Content-Type': 'application/json',
                      'Accept': 'application/json'
                  }
              }
          );

          return {
              status: 'success',
              userId: response.data.id
          };
      } catch (error) {
          console.error('Okta API error:', {
              status: error.response?.status,
              data: error.response?.data,
              message: error.message
          });
          req.error(500, 'Failed to create user in Okta.');
      }
  });
    this.on('getOktaGroups', async (req) => {
        const axios = require('axios');
        const query = req.data.query || ''; // Default to empty if no query provided
        const OKTA_API_TOKEN = process.env.OKTA_API_TOKEN;
        const OKTA_API_URL = process.env.OKTA_API_URL;
        try {
          const response = await axios.get(
            `${OKTA_API_URL}groups?q=MFG`,
            {
              headers: {
                'Authorization': `SSWS ${OKTA_API_TOKEN}`,
                'Accept': 'application/json'
              }
            }
          );
      
          return response.data.map(group => ({
            id: group.id,
            profile: {
              name: group.profile.name,
              description: group.profile.description
            }
          }));
        } catch (error) {
          console.error('Okta API error (getOktaGroups):', error?.response?.data || error.message);
          req.error(500, 'Failed to fetch Okta groups.');
        }
    });
    this.on('createOktaGroup', async (req) => {
        const axios = require('axios');
        const groupData = req.data.group;
        const OKTA_API_TOKEN = process.env.OKTA_API_TOKEN;
        const OKTA_API_URL = process.env.OKTA_API_URL;
    
        try {
            const response = await axios.post(
                `${OKTA_API_URL}groups`,
                { profile: groupData.profile },
                {
                    headers: {
                        'Authorization': `SSWS ${OKTA_API_TOKEN}`,
                        'Content-Type': 'application/json'
                    }
                }
            );
    
            return {
                id: response.data.id,
                profile: {
                    name: response.data.profile.name,
                    description: response.data.profile.description
                }
            };
        } catch (error) {
            console.error("Okta API error (createOktaGroup):", error?.response?.data || error.message);
            req.error(500, "Failed to create Okta group.");
        }
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

