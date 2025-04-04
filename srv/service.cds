// Processing Service

using RETURNS as ENTRETURNS from '../db/schema';
using RETCUST as ENTRETCUST from '../db/schema';
using RETRGA as ENTRETRGA from '../db/schema';
using RETREASON as ENTRETREASON from '../db/schema';
using RETVKORG as ENTRETVKORG from '../db/schema';
using RETMFRNR as ENTRETMFRNR from '../db/schema';
using RETVKBUR as ENTRETVKBUR from '../db/schema';

using SHIPPINGHISTORY as ENTSHIPPINGHISTORY from '../db/schema';
using SHINVOICE as ENTSHINVOICE from '../db/schema';
using SHCUSTOMER as ENTSHCUSTOMER from '../db/schema';
using SHCARRIER as ENTSHCARRIER from '../db/schema';
using SHTRACKING as ENTTRACKING from '../db/schema';
using SHSHIPTO as ENTSHSHIPTO from '../db/schema';
using SHMFRNR as ENTSHMFRNR from '../db/schema';
using SHVKORG as ENTSHVKORG from '../db/schema';

using BACKORDERS as ENTBACKORDERS from '../db/schema';
using BOPRODUCTDESC as ENTBOPRODUCTDESC from '../db/schema';
using BOSHIPTO as ENTBOSHIPTO from '../db/schema';
using BOBILLTO as ENTBOBILLTO from '../db/schema';
using BOMFRNR as ENTBOMFRNR from '../db/schema';
using BOVKORG as ENTBOVKORG from '../db/schema';

using OPENORDERS as ENTOPENORDERS from '../db/schema';
using OOPRODDESC as ENTOOPRODDESC from '../db/schema';
using OOCUST as ENTOOCUST from '../db/schema';
using OOSHIPTO as ENTOOSHIPTO from '../db/schema';
using OOPROVINCE as ENTOOPROVINCE from '../db/schema';


service PROCESSING {
    // ℹ️ Returns Related Entities
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR and $user.SalesOrg = CO_VKORG and $user.SalesOffice = SALES_OFFICE_VKBUR and $user.ProfitCentre = PROFIT_CENTER_PRCTR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity RETURNS as projection on ENTRETURNS;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity RETCUST as projection on ENTRETCUST;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity RETRGA as projection on ENTRETRGA; 
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity RETREASON as projection on ENTRETREASON;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.SalesOrg = CO_VKORG' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity RETVKORG as projection on ENTRETVKORG;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity RETMFRNR as projection on ENTRETMFRNR;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.SalesOffice = SALES_OFFICE_VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity RETVKBUR as projection on ENTRETVKBUR;



    // ℹ️ Shipping History Related Entities
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHIPPINGHISTORY as projection on ENTSHIPPINGHISTORY;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHINVOICE as projection on ENTSHINVOICE;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHCUSTOMER as projection on ENTSHCUSTOMER;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHCARRIER as projection on ENTSHCARRIER;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHTRACKING as projection on ENTTRACKING;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHSHIPTO as projection on ENTSHSHIPTO;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHMFRNR as projection on ENTSHMFRNR;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHVKORG as projection on ENTSHVKORG;



    // ℹ️ Open Orders Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity OPENORDERS as projection on ENTOPENORDERS;
    entity OOPRODDESC as projection on ENTOOPRODDESC;
    entity OOSHIPTO as projection on ENTOOSHIPTO;
    entity OOCUST as projection on ENTOOCUST;
    entity OOPROVINCE as projection on ENTOOPROVINCE;




    // ℹ️ Back Orders Related Entities
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BACKORDERS as projection on ENTBACKORDERS;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOBILLTO as projection on ENTBOBILLTO;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOSHIPTO as projection on ENTBOSHIPTO;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOPRODUCTDESC as projection on ENTBOPRODUCTDESC;
    // ✅ CDS Authorization Complete    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOMFRNR as projection on ENTBOMFRNR;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOVKORG as projection on ENTBOVKORG;
}

// Inventory Audit Trail
using INVENTORYAUDITTRAIL as ENTINVENTORYAUDITTRAIL from '../db/schema';
using IATPRODUCTCODE as ENTIATPRODUCTCODE from '../db/schema';
using IATLOT as ENTIATLOT from '../db/schema';
using IATWAREHOUSE as ENTIATWAREHOUSE from '../db/schema';
using IATCUSTSUPP as ENTIATCUSTSUPP from '../db/schema';

// Inventory Status
using INVENTORYSTATUS as ENTINVENTORYSTATUS from '../db/schema';
using INVSTATUSPRODUCTCODE as ENTINVSTATUSPRODUCTCODE from '../db/schema';
using INVSTATUSMFRNR as ENTINVSTATUSMFRNR from '../db/schema';
using INVSTATUSVKBUR as ENTINVSTATUSVKBUR from '../db/schema';

// Inventory By Lot
using INVENTORYBYLOT as ENTINVENTORYBYLOT from '../db/schema';
using INVBYLOTPRODUCTCODE as ENTINVBYLOTPRODUCTCODE from '../db/schema';
using INVBYLOTLOT as ENTINVBYLOTLOT from '../db/schema';
using INVBYLOTWAREHOUSE as ENTINVBYLOTWAREHOUSE from '../db/schema';
using INVBYLOTMFRNR as ENTINVBYLOTMFRNR from '../db/schema';
using INVBYLOTVKBUR as ENTINVBYLOTVKBUR from '../db/schema';

// Inventory Snapshot
using INVENTORYSNAPSHOT as ENTINVENTORYSNAPSHOT from '../db/schema';
using INVSNAPPRODDESC as ENTINVSNAPPRODDESC from '../db/schema';
using INVSNAPPROD as ENTINVSNAPPROD from '../db/schema';
using INVSNAPMFRNR as ENTINVSNAPMFRNR from '../db/schema';
using INVSNAPVKORG as ENTINVSNAPVKORG from '../db/schema';
using INVSNAPLOT as ENTINVSNAPLOT from '../db/schema';
using INVSNAPWARESTAT as ENTINVSNAPWARESTAT from '../db/schema';

// Inventory Valuation
using INVENTORYVALUATION as ENTINVENTORYVALUATION from '../db/schema';
using INVVALPRODDESC as ENTINVVALPRODDESC from '../db/schema';
using INVVALPROD as ENTINVVALPROD from '../db/schema';
using INVVALMFRNR as ENTINVVALMFRNR from '../db/schema';
using INVVALVKBUR as ENTINVVALVKBUR from '../db/schema';

// Item Master
using ITEMMASTER as ENTITEMMASTER from '../db/schema';
using ITEMMASPD as ENTITEMMASPD from '../db/schema';
using ITEMMASCATEGORY as ENTITEMMASCATEGORY from '../db/schema';

// Inventory Service
service INVENTORY {
    // ℹ️ Inventory Audit Trail Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVENTORYAUDITTRAIL as projection on ENTINVENTORYAUDITTRAIL; 
    entity IATPRODUCTCODE as projection on ENTIATPRODUCTCODE;
    entity IATLOT as projection on ENTIATLOT;
    entity IATWAREHOUSE as projection on ENTIATWAREHOUSE;
    entity IATCUSTSUPP as projection on ENTIATCUSTSUPP;



    // ℹ️ Inventory Valuation Related Entities
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR and $user.SalesOffice = SALES_OFFICE_VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVENTORYVALUATION as projection on ENTINVENTORYVALUATION;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR and $user.SalesOffice = SALES_OFFICE_VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVVALPRODDESC as projection on ENTINVVALPRODDESC;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR and $user.SalesOffice = SALES_OFFICE_VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVVALPROD as projection on ENTINVVALPROD;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVVALMFRNR as projection on ENTINVVALMFRNR;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRNR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVVALVKBUR as projection on ENTINVVALVKBUR;




    // ℹ️ Inventory Status Related Entities
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRPN and $user.SalesOffice = VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVENTORYSTATUS as projection on ENTINVENTORYSTATUS;

    
    entity INVSTATUSPRODUCTCODE as projection on ENTINVSTATUSPRODUCTCODE;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MANUFACTURER_MFRPN ' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVSTATUSMFRNR as projection on ENTINVSTATUSMFRNR;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.SalesOffice = VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVSTATUSVKBUR as projection on ENTINVSTATUSVKBUR;




    // ℹ️ Inventory By Lot Related Entities
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MFRPN and $user.SalesOffice = VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVENTORYBYLOT as projection on ENTINVENTORYBYLOT;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MFRPN and $user.SalesOffice = VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVBYLOTPRODUCTCODE as projection on ENTINVBYLOTPRODUCTCODE;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MFRPN and $user.SalesOffice = VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVBYLOTLOT as projection on ENTINVBYLOTLOT;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MFRPN and $user.SalesOffice = VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVBYLOTWAREHOUSE as projection on ENTINVBYLOTWAREHOUSE;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.ManufacturerNumber = MFRPN' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVBYLOTMFRNR as projection on ENTINVBYLOTMFRNR;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        {   
            grant: 'READ', 
            to: 'Viewer', 
            where: '$user.SalesOffice = VKBUR' 
        },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVBYLOTVKBUR as projection on ENTINVBYLOTVKBUR;



    // ℹ️ Item Master Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MANUFACTURERNUMBER and $user.SalesOrg = SALESORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity ITEMMASTER as projection on ENTITEMMASTER;
    entity ITEMMASPD as projection on ENTITEMMASPD;
    entity ITEMMASCATEGORY as projection on ENTITEMMASCATEGORY;




    // ℹ️ Lot Inventory Snapshot Related Entities 
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVENTORYSNAPSHOT as projection on ENTINVENTORYSNAPSHOT;

    
    entity INVSNAPPRODDESC as projection on ENTINVSNAPPRODDESC;

   
    
    entity INVSNAPPROD as projection on ENTINVSNAPPROD;

    
    entity INVSNAPMFRNR as projection on ENTINVSNAPMFRNR;

   
    entity INVSNAPVKORG as projection on ENTINVSNAPVKORG;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVSNAPLOT as projection on ENTINVSNAPLOT;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVSNAPWARESTAT as projection on ENTINVSNAPWARESTAT;
}

using INVOICEHISTORY as ENTINVOICEHISTORY from '../db/schema';
using IHCUSTOMER as ENTIHCUSTOMER from '../db/schema';
using IHCUSTOMERID as ENTIHCUSTOMERID from '../db/schema';
using IHSHIPTO as ENTIHSHIPTO from '../db/schema';
using IHINVOICE as ENTIHINVOICE from '../db/schema';
using IHPO as ENTIHPO from '../db/schema';
using IHTYPE as ENTIHTYPE from '../db/schema';
using IHPROVINCE as ENTIHPROVINCE from '../db/schema';

using SALESBYCURRENT as ENTSALESBYCURRENT from '../db/schema';
using SBCINVOICE as ENTSBCINVOICE from '../db/schema';
using SBCPRODDESC as ENTSBCPRODDESC from '../db/schema';
using SBCTYPE as ENTSBCTYPE from '../db/schema';
using SBCLOT as ENTSBCLOT from '../db/schema';
using SBCWAREHOUSE as ENTSBCWAREHOUSE from '../db/schema';
using SBCBILLTO as ENTSBCBILLTO from '../db/schema';
using SBCSHIPTO as ENTSBCSHIPTO from '../db/schema';

service SALES {
    // ℹ️ Ivoice History Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVOICEHISTORY as projection on ENTINVOICEHISTORY;
    entity IHCUSTOMERID as projection on ENTIHCUSTOMERID;
    entity IHCUSTOMER as projection on ENTIHCUSTOMER;
    entity IHSHIPTO as projection on ENTIHSHIPTO;
    entity IHINVOICE as projection on ENTIHINVOICE;
    entity IHPO as projection on ENTIHPO;
    entity IHTYPE as projection on ENTIHTYPE;
    entity IHPROVINCE as projection on ENTIHPROVINCE;



    // ℹ️ Sales By Product/Customer Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.SalesOrg = CO_VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SALESBYCURRENT as projection on ENTSALESBYCURRENT;
    entity SBCINVOICE as projection on ENTSBCINVOICE;
    entity SBCPRODDESC as projection on ENTSBCPRODDESC;
    entity SBCTYPE as projection on ENTSBCTYPE;
    entity SBCLOT as projection on ENTSBCLOT;
    entity SBCWAREHOUSE as projection on ENTSBCWAREHOUSE;
    entity SBCBILLTO as projection on ENTSBCBILLTO;
    entity SBCSHIPTO as projection on ENTSBCSHIPTO;
}

using CUSTOMERMASTER as ENTCUSTOMERMASTER from '../db/schema';
using KUNN2_BILLTO as ENTKUNN2_BILLTO from '../db/schema';
using KUNN2_SHIPTO as ENTKUNN2_SHIPTO from '../db/schema';
using CAL_CUST_STATUS as ENTCAL_CUST_STATUS from '../db/schema';

using PRICING as ENTPRICING from '../db/schema';
using PRICINGPRICEDESC as ENTPRICINGPRICEDESC from '../db/schema';
using PRICINGPRODUCTDESC as ENTPRICINGPRODUCTDESC from '../db/schema';

service CUSTOMERS {
    // ℹ️ Customer Listing Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity CUSTOMERMASTER as projection on ENTCUSTOMERMASTER;
    entity KUNN2_BILLTO as projection on ENTKUNN2_BILLTO;
    entity KUNN2_SHIPTO as projection on ENTKUNN2_SHIPTO;
    entity CAL_CUST_STATUS as projection on ENTCAL_CUST_STATUS;




    // ℹ️ Pricing Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity PRICING as projection on ENTPRICING;
    entity PRICINGPRICEDESC as projection on ENTPRICINGPRICEDESC;
    entity PRICINGPRODUCTDESC as projection on ENTPRICINGPRODUCTDESC;
}

using CASHJOURNAL as ENTCASHJOURNAL from '../db/schema';
using BLARTS as ENTBLARTS from '../db/schema';
using BILL_TOS as ENTBILL_TOS from '../db/schema';

using OPENAR as ENTOPENAR from '../db/schema';
using OPENARCUSTOMER as ENTOPENARCUSTOMER from '../db/schema';

service FINANCE {
    // ℹ️ Accounts Receivable Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity OPENAR as projection on ENTOPENAR;
    entity OPENARCUSTOMER as projection on ENTOPENARCUSTOMER;




    // ℹ️ Cash Journal Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG and $user.ProfitCentre = PRCTR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity CASHJOURNAL as projection on ENTCASHJOURNAL;
    entity BLARTS as projection on ENTBLARTS;
    entity BILL_TOS as projection on ENTBILL_TOS;
}

using MAINPAGESUMMARY as ENTMAINPAGESUMMARY from '../db/schema';
using MPSYEAR as ENTMPSYEAR from '../db/schema';
using MAINPAGEINVENTORY as ENTMAINPAGEINVENTORY from '../db/schema';
using MAINPAGEUNIT as ENTMAINPAGEUNIT from '../db/schema';
using MPUYEAR as ENTMPUYEAR from '../db/schema';

service MAINPAGE {
    // ⚠️ CDS Authorization Pending
    entity MAINPAGESUMMARY as projection on ENTMAINPAGESUMMARY;
    entity MPSYEAR as projection on ENTMPSYEAR;
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MANUFACTURER_MFRPN' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity MAINPAGEINVENTORY as projection on ENTMAINPAGEINVENTORY;
    // ⚠️ CDS Authorization Pending
    entity MAINPAGEUNIT as projection on ENTMAINPAGEUNIT;
    entity MPUYEAR as projection on ENTMPUYEAR;
} 

service CatalogService {
    @requires: 'authenticated-user'
    @readonly entity Invoices {
        key ID: UUID;
        InvoiceNumber: String;
    }  
}

using MediaFile as ENTMediaFile from '../db/schema';
service Media {
    entity MediaFile as projection on ENTMediaFile
}
annotate Media.MediaFile with @odata.draft.enabled: true;









    
    