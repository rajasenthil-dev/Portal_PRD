// console.log("--- [MEDIA-SERVICE-DEBUG] media-service.js: File is being loaded by Node.js ---");

// const cds = require('@sap/cds');

// module.exports = cds.service.impl(async function (srv) {
//     const { MediaFile } = srv.entities;
//     const LOG_SERVICE = cds.log('media-service');

//     if (!MediaFile) {
//         LOG_SERVICE.error("CRITICAL: MediaFile entity is not defined in srv.entities. Service handlers for MediaFile will fail. Check CDS model, namespaces, and service definitions in your service.cds.");
//         return;
//     }

//     // SINGLE, COMPREHENSIVE CLEANUP HANDLER FOR UPDATE
//     // This MUST be the first 'before' handler for 'UPDATE' on MediaFile.
//     srv.before('UPDATE', MediaFile, (req) => {
//         const LOG_CLEANUP = cds.log('media-update-cleanup');
//         if (req.data) { // Check if req.data exists
//             if (req.data.hasOwnProperty('url')) {
//                 LOG_CLEANUP.info(`Client sent 'url' property in UPDATE request for MediaFile ID ${req.data.ID || req.params[0]?.ID}. Removing it as it's a computed field.`);
//                 delete req.data.url;
//             }

//             // Remove other read-only or server-managed fields that a client should not set during an update
//             if (req.data.hasOwnProperty('ID') && req.event === 'UPDATE') {
//                 // While keys are in req.params for updates, a client might wrongly send ID in payload.
//                 // It's safer to ensure it's not in req.data to avoid confusion, though CAP usually ignores it.
//                 // However, changing a key is a different operation (delete old, create new).
//                 // For simplicity, if ID is in req.data for an update, it's usually an error or for optimistic locking,
//                 // but we are not handling optimistic locking here. Let's remove it if sent.
//                 LOG_CLEANUP.trace(`Removing 'ID' from req.data for UPDATE if present.`);
//                 delete req.data.ID;
//             }
//             if (req.data.hasOwnProperty('IsActiveEntity')) { // This is managed by the draft protocol
//                 LOG_CLEANUP.trace(`Removing 'IsActiveEntity' from req.data for UPDATE if present.`);
//                 delete req.data.IsActiveEntity;
//             }
//             if (req.data.hasOwnProperty('createdAt')) delete req.data.createdAt;
//             if (req.data.hasOwnProperty('createdBy')) delete req.data.createdBy;
//             if (req.data.hasOwnProperty('modifiedAt')) delete req.data.modifiedAt;
//             if (req.data.hasOwnProperty('modifiedBy')) delete req.data.modifiedBy;
//         }
//     });

//     /**
//      * Placeholder Uniqueness Management:
//      * This will run AFTER the cleanup handler for UPDATE operations.
//      */
//     srv.before(['CREATE', 'UPDATE'], MediaFile, async (req) => {
//         const LOG_HOOK = cds.log('placeholder-manager');
//         const recordIsPlaceholder = req.data.hasOwnProperty('isPlaceholder') ? req.data.isPlaceholder : undefined;
//         const recordID = req.data.ID || (req.params[0]?.ID); // For CREATE, ID is not in params. For UPDATE, it is.

//         if (recordIsPlaceholder === true) {
//             LOG_HOOK.info(`Attempting to set MediaFile (ID: ${recordID || 'NEW DRAFT/RECORD'}) as the placeholder.`);
//             const tx = cds.transaction(req);
//             try {
//                 let unsettingQuery = UPDATE(MediaFile)
//                     .set({ isPlaceholder: false })
//                     .where({ isPlaceholder: true });

//                 if (req.event === 'UPDATE' && recordID) {
//                     unsettingQuery.where.and `ID != ${recordID}`;
//                 }

//                 const unsetResult = await tx.run(unsettingQuery);
//                 LOG_HOOK.info(unsetResult > 0 ?
//                     `Successfully unset ${unsetResult} other record(s) that were previously placeholders.` :
//                     'No other records found/unset as placeholders.'
//                 );
//             } catch (error) {
//                 LOG_HOOK.error('Error during placeholder uniqueness management:', error);
//                 req.error(500, `Failed to update placeholder status due to an internal error: ${error.message}`);
//             }
//         } else if (req.data.hasOwnProperty('isPlaceholder')) {
//             LOG_HOOK.debug(`MediaFile (ID: ${recordID || 'NEW DRAFT/RECORD'}) processed with isPlaceholder=${req.data.isPlaceholder}.`);
//         }
//     });

//     /**
//      * getCurrentManufacturerLogo Implementation:
//      */
//     srv.on('getCurrentManufacturerLogo', async (req) => {
//         const LOG_FUNC = cds.log('get-current-logo-func');
//         let logoToReturn = null;
//         const servicePath = srv.path || '/media-service';

//         const user = req.user;
//         if (!user || !user.attr) {
//             LOG_FUNC.warn("User attributes not available. Falling back to placeholder search.");
//         }
//         const userMfgNo = user?.attr?.ManufacturerNumber || user?.attr?.manufacturer_number;
//         const isInternalUser = user ? user.is('Internal') : false;

//         LOG_FUNC.info(`Invoked by User: ${user?.id || 'anonymous/unknown'}, UserMfgNo: '${userMfgNo}', IsInternalRole: ${isInternalUser}`);

//         if (userMfgNo && !isInternalUser) {
//             try {
//                 logoToReturn = await SELECT.one.from(MediaFile)
//                     .where({ manufacturerNumber: userMfgNo, isPlaceholder: false });
//                 if (logoToReturn) {
//                     LOG_FUNC.info(`Found specific logo for MfgNo '${userMfgNo}'. ID: ${logoToReturn.ID}`);
//                 } else {
//                     LOG_FUNC.info(`No specific logo for MfgNo '${userMfgNo}'. Falling back.`);
//                 }
//             } catch (error) {
//                 LOG_FUNC.error(`Error fetching specific logo for MfgNo '${userMfgNo}':`, error);
//             }
//         } else if (isInternalUser) {
//             LOG_FUNC.info('User is "Internal". Using placeholder logic.');
//         } else {
//             LOG_FUNC.info(`User '${user?.id || 'anonymous/unknown'}' not 'Internal' or no MfgNo. Using placeholder logic.`);
//         }

//         if (!logoToReturn) {
//             LOG_FUNC.info('Attempting to fetch the global placeholder logo.');
//             try {
//                 logoToReturn = await SELECT.one.from(MediaFile).where({ isPlaceholder: true });
//                 if (logoToReturn) {
//                     LOG_FUNC.info(`Successfully fetched placeholder logo. ID: ${logoToReturn.ID}`);
//                 } else {
//                     LOG_FUNC.warn('No placeholder logo found in the database.');
//                 }
//             } catch (error) {
//                 LOG_FUNC.error('Error fetching placeholder logo:', error);
//             }
//         }

//         if (!logoToReturn) {
//             LOG_FUNC.error('No logo could be returned (neither specific nor placeholder).');
//             return req.reject(404, 'Logo not available. Ensure a placeholder logo is configured.');
//         }

//         logoToReturn.url = `${servicePath}/MediaFile(ID=${logoToReturn.ID},IsActiveEntity=true)/content`;
//         LOG_FUNC.info(`Returning logo. ID: ${logoToReturn.ID}, FileName: ${logoToReturn.fileName}, IsPlaceholder: ${logoToReturn.isPlaceholder}, URL: ${logoToReturn.url}`);
//         return logoToReturn;
//     });

//     /**
//      * Calculate Virtual 'url' Field on READ
//      */
//     srv.after('READ', MediaFile, (record, req) => {
//         if (!record) return;
//         // **** ADD THIS LOG ****
//         // Log the record as it's received from the database/core service, before we add/modify 'url'
//         // Using JSON.parse(JSON.stringify(record)) for a clean deep copy for logging,
//         // especially if 'record' is a rich object.
//         // **** SIMPLIFIED LOG TO CHECK INVOCATION ****
//         console.log(`--- srv.after('READ', MediaFile) triggered. Record ID (if available): ${record ? record.ID : 'No record object passed'} ---`);
//         console.log("Record received in srv.after('READ', MediaFile):", JSON.parse(JSON.stringify(record)));
//         // *********************

//         const servicePath = srv.path || '/media-service';
//         if (record.ID) {
//             const isActiveEntity = (typeof record.IsActiveEntity === 'boolean') ? record.IsActiveEntity : true;
//             record.url = `${servicePath}/MediaFile(ID=${record.ID},IsActiveEntity=${isActiveEntity})/content`;
//             console.log("Record after adding URL:", JSON.parse(JSON.stringify(record)));
//         }
//     });

//     LOG_SERVICE.info('Media service initialized with custom handlers.');
// });