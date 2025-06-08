// Processing Service

using RETURNS as ENTRETURNS from '../db/schema';
using RETCUST as ENTRETCUST from '../db/schema';
using RETCUSTNAME as ENTRETCUSTNAME from '../db/schema';
using RETRGA as ENTRETRGA from '../db/schema';
using RETREASON as ENTRETREASON from '../db/schema';
using RETVKORG as ENTRETVKORG from '../db/schema';
using RETMFRNR as ENTRETMFRNR from '../db/schema';
using RETMFRNRNAME as ENTRETMFRNRNAME from '../db/schema';
using RETVKBUR as ENTRETVKBUR from '../db/schema';

using SHIPPINGHISTORY as ENTSHIPPINGHISTORY from '../db/schema';
using SHINVOICE as ENTSHINVOICE from '../db/schema';
using SHCUSTOMER as ENTSHCUSTOMER from '../db/schema';
using SHCARRIER as ENTSHCARRIER from '../db/schema';
using SHTRACKING as ENTTRACKING from '../db/schema';
using SHSHIPTO as ENTSHSHIPTO from '../db/schema';
using SHSHIPTONAME as ENTSHSHIPTONAME from '../db/schema';
using SHMFRNR as ENTSHMFRNR from '../db/schema';
using SHMFRNRNAME as ENTSHMFRNRNAME from '../db/schema';
using SHVKORG as ENTSHVKORG from '../db/schema';

using BACKORDERS as ENTBACKORDERS from '../db/schema';
using BOPRODUCTDESC as ENTBOPRODUCTDESC from '../db/schema';
using BOPRODUCT as ENTBOPRODUCT from '../db/schema';
using BOSHIPTO as ENTBOSHIPTO from '../db/schema';
using BOSHIPTONAME as ENTBOSHIPTONAME from '../db/schema';
using BOBILLTO as ENTBOBILLTO from '../db/schema';
using BOMFRNR as ENTBOMFRNR from '../db/schema';
using BOMFRNRNAME as ENTBOMFRNRNAME from '../db/schema';
using BOVKORG as ENTBOVKORG from '../db/schema';

using OPENORDERS as ENTOPENORDERS from '../db/schema';
using OOPRODDESC as ENTOOPRODDESC from '../db/schema';
using OOPROD as ENTOOPROD from '../db/schema';
using OOCUST as ENTOOCUST from '../db/schema';
using OOSHIPTO as ENTOOSHIPTO from '../db/schema';
using OOSHIPTONAME as ENTOOSHIPTONAME from '../db/schema';
using OOPROVINCE as ENTOOPROVINCE from '../db/schema';
using OOMFRNR as ENTOOMFRNR from '../db/schema';
using OOVKORG as ENTOOVKORG from '../db/schema';
using OOMFRNRNAME as ENTOOMFRNRNAME from '../db/schema';
using OOVBELN as ENTOOVBELN from '../db/schema';

using SHIPPINGSTATUS as ENTSHIPPINGSTATUS from '../db/schema';

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
    entity RETCUSTNAME as projection on ENTRETCUSTNAME;
    
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
    entity RETMFRNRNAME as projection on ENTRETMFRNRNAME;
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
    entity SHSHIPTONAME as projection on ENTSHSHIPTONAME;

    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SHMFRNR as projection on ENTSHMFRNR;
    entity SHMFRNRNAME as projection on ENTSHMFRNRNAME;

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
    entity OOPROD as projection on ENTOOPROD;
    entity OOSHIPTO as projection on ENTOOSHIPTO;
    entity OOSHIPTONAME as projection on ENTOOSHIPTONAME;
    entity OOCUST as projection on ENTOOCUST;
    entity OOPROVINCE as projection on ENTOOPROVINCE;
    entity OOMFRNR as projection on ENTOOMFRNR;
    entity OOVKORG as projection on ENTOOVKORG;
    entity OOMFRNRNAME as projection on ENTOOMFRNRNAME;
    entity OOVBELN as projection on ENTOOVBELN;




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
    entity BOSHIPTONAME as projection on ENTBOSHIPTONAME;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOPRODUCTDESC as projection on ENTBOPRODUCTDESC;
    entity BOPRODUCT as projection on ENTBOPRODUCT;
    // ✅ CDS Authorization Complete    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOMFRNR as projection on ENTBOMFRNR;
    entity BOMFRNRNAME as projection on ENTBOMFRNRNAME;
    // ✅ CDS Authorization Complete
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.SalesOrg = VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity BOVKORG as projection on ENTBOVKORG;

    // ℹ️ Shipping Status Related Entities
    // ✅ CDS Authorization Complete
    // @requires: 'authenticated-user'
    // @restrict: [
    //     { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR and $user.SalesOrg = VKORG' },
    //     { grant: 'READ', to: 'Internal' }
    // ]
    entity SHIPPINGSTATUS as projection on ENTSHIPPINGSTATUS;
}

// Inventory Audit Trail
using INVENTORYAUDITTRAIL as ENTINVENTORYAUDITTRAIL from '../db/schema';
using IATPRODUCTCODE as ENTIATPRODUCTCODE from '../db/schema';
using IATLOT as ENTIATLOT from '../db/schema';
using IATSALESORG as ENTIATSALESORG from '../db/schema';
using IATWAREHOUSE as ENTIATWAREHOUSE from '../db/schema';
using IATCUSTSUPP as ENTIATCUSTSUPP from '../db/schema';
using IATCUSTSUPPNAME as ENTIATCUSTSUPPNAME from '../db/schema';
using IATMFRNR as ENTIATMFRNR from '../db/schema';
using IATMFRNRNAME as ENTIATMFRNRNAME from '../db/schema';
using IATTRANTYPE as ENTIATTRANTYPE from '../db/schema';
using IATPLANTNAME as ENTIATPLANTNAME from '../db/schema';

// Inventory Status
using INVENTORYSTATUS as ENTINVENTORYSTATUS from '../db/schema';
using INVSTATUSPRODUCTCODE as ENTINVSTATUSPRODUCTCODE from '../db/schema';
using INVSTATUSMFRNR as ENTINVSTATUSMFRNR from '../db/schema';
using INVSTATUSMFRNRNAME as ENTINVSTATUSMFRNRNAME from '../db/schema';
using INVSTATUSVKBUR as ENTINVSTATUSVKBUR from '../db/schema';
using INVSTATUSPLANTNAME as ENTINVSTATUSPLANTNAME from '../db/schema';

// Inventory By Lot
using INVENTORYBYLOT as ENTINVENTORYBYLOT from '../db/schema';
using INVBYLOTPRODUCTCODE as ENTINVBYLOTPRODUCTCODE from '../db/schema';
using INVBYLOTLOT as ENTINVBYLOTLOT from '../db/schema';
using INVBYLOTWAREHOUSE as ENTINVBYLOTWAREHOUSE from '../db/schema';
using INVBYLOTMFRNR as ENTINVBYLOTMFRNR from '../db/schema';
using INVBYLOTMFRNRNAME as ENTINVBYLOTMFRNRNAME from '../db/schema';
using INVBYLOTVKBUR as ENTINVBYLOTVKBUR from '../db/schema';
using INVBYLOTPLANTNAME as ENTINVBYLOTPLANTNAME from '../db/schema';

// Inventory Snapshot
using INVENTORYSNAPSHOT as ENTINVENTORYSNAPSHOT from '../db/schema';
using INVSNAPPRODDESC as ENTINVSNAPPRODDESC from '../db/schema';
using INVSNAPPROD as ENTINVSNAPPROD from '../db/schema';
using INVSNAPPRODSKU as ENTINVSNAPPRODSKU from '../db/schema';
using INVSNAPMFRNR as ENTINVSNAPMFRNR from '../db/schema';
using INVSNAPMFRNRNAME as ENTINVSNAPMFRNRNAME from '../db/schema';
using INVSNAPVKORG as ENTINVSNAPVKORG from '../db/schema';
using INVSNAPLOT as ENTINVSNAPLOT from '../db/schema';
using INVSNAPWARESTAT as ENTINVSNAPWARESTAT from '../db/schema';
using INVSNAPPLANTNAME as ENTINVSNAPPLANTNAME from '../db/schema';

// Inventory Valuation
using INVENTORYVALUATION as ENTINVENTORYVALUATION from '../db/schema';
using INVVALPRODDESC as ENTINVVALPRODDESC from '../db/schema';
using INVVALPROD as ENTINVVALPROD from '../db/schema';
using INVVALPRODSKU as ENTINVVALPRODSKU from '../db/schema';
using INVVALMFRNR as ENTINVVALMFRNR from '../db/schema';
using INVVALMFRNRNAME as ENTINVVALMFRNRNAME from '../db/schema';
using INVVALVKBUR as ENTINVVALVKBUR from '../db/schema';
using INVVALPLANTNAME as ENTINVVALPLANTNAME from '../db/schema';

// Item Master
using ITEMMASTER as ENTITEMMASTER from '../db/schema';
using ITEMMASP as ENTITEMMASP from '../db/schema';
using ITEMMASPD as ENTITEMMASPD from '../db/schema';
using ITEMMASPSID as ENTITEMMASPSID from '../db/schema';
using ITEMMASCATEGORY as ENTITEMMASCATEGORY from '../db/schema';
using ITEMMASMFRNR as ENTITEMMASMFRNR from '../db/schema';
using ITEMMASMFRNRNAME as ENTITEMMASMFRNRNAME from '../db/schema';
using ITEMMASSALESORG as ENTITEMMASSALESORG from '../db/schema';
using ITEMMASPLANTNAME as ENTITEMMASPLANTNAME from '../db/schema';

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
    entity IATCUSTSUPPNAME as projection on ENTIATCUSTSUPPNAME;
    entity IATMFRNR as projection on ENTIATMFRNR;
    entity IATMFRNRNAME as projection on ENTIATMFRNRNAME;
    entity IATSALESORG as projection on ENTIATSALESORG;
    entity IATTRANTYPE as projection on ENTIATTRANTYPE;
    entity IATPLANTNAME as projection on ENTIATPLANTNAME;



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
    entity INVVALPRODSKU as projection on ENTINVVALPRODSKU;
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
    entity INVVALMFRNRNAME as projection on ENTINVVALMFRNRNAME;
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
    entity INVVALPLANTNAME as projection on ENTINVVALPLANTNAME;




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
    entity INVSTATUSMFRNRNAME as projection on ENTINVSTATUSMFRNRNAME;

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
    entity INVSTATUSPLANTNAME as projection on ENTINVSTATUSPLANTNAME;



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
    entity INVBYLOTMFRNRNAME as projection on ENTINVBYLOTMFRNRNAME;

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
    entity INVBYLOTPLANTNAME as projection on ENTINVBYLOTPLANTNAME;



    // ℹ️ Item Master Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MANUFACTURERNUMBER and $user.SalesOrg = SALESORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity ITEMMASTER as projection on ENTITEMMASTER;
    entity ITEMMASP as projection on ENTITEMMASP;
    entity ITEMMASPD as projection on ENTITEMMASPD;
    entity ITEMMASPSID as projection on ENTITEMMASPSID;
    entity ITEMMASCATEGORY as projection on ENTITEMMASCATEGORY;
    entity ITEMMASMFRNR as projection on ENTITEMMASMFRNR;
    entity ITEMMASMFRNRNAME as projection on ENTITEMMASMFRNRNAME;
    entity ITEMMASSALESORG as projection on ENTITEMMASSALESORG;
    entity ITEMMASPLANTNAME as projection on ENTITEMMASPLANTNAME;




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
    entity INVSNAPPRODSKU as projection on ENTINVSNAPPRODSKU;
    
    entity INVSNAPMFRNR as projection on ENTINVSNAPMFRNR;
    entity INVSNAPMFRNRNAME as projection on ENTINVSNAPMFRNRNAME;

   
    entity INVSNAPVKORG as projection on ENTINVSNAPVKORG;
    entity INVSNAPPLANTNAME as projection on ENTINVSNAPPLANTNAME;

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
using IHSHIPTO as ENTIHSHIPTO from '../db/schema';
using IHINVOICE as ENTIHINVOICE from '../db/schema';
using IHPO as ENTIHPO from '../db/schema';
using IHTYPE as ENTIHTYPE from '../db/schema';
using IHPROVINCE as ENTIHPROVINCE from '../db/schema';
using IHMFRNR as ENTIHMFRNR from '../db/schema';
using IHMFRNRNAME as ENTIHMFRNRNAME from '../db/schema';
using IHSALESORG as ENTIHSALESORG from '../db/schema';
using IHBEZEI as ENTIHBEZEI from '../db/schema';
using IHPLANTNAME as ENTIHPLANTNAME from '../db/schema';

using SALESBYCURRENTWOPID as ENTSALESBYCURRENTWOPID from '../db/schema';
using SALESBYCURRENT as ENTSALESBYCURRENT from '../db/schema';
using SBCINVOICE as ENTSBCINVOICE from '../db/schema';
using SBCPRODDESC as ENTSBCPRODDESC from '../db/schema';
using SBCTYPE as ENTSBCTYPE from '../db/schema';
using SBCLOT as ENTSBCLOT from '../db/schema';
using SBCWAREHOUSE as ENTSBCWAREHOUSE from '../db/schema';
using SBCBILLTO as ENTSBCBILLTO from '../db/schema';
using SBCSHIPTO as ENTSBCSHIPTO from '../db/schema';
using SBCBILLTOID as ENTSBCBILLTOID from '../db/schema';
using SBCSHIPTOID as ENTSBCSHIPTOID from '../db/schema';
using SBCMFRNR as ENTSBCMFRNR from '../db/schema';
using SBCMFRNRNAME as ENTSBCMFRNRNAME from '../db/schema';
using SBCSALESORG as ENTSBCSALESORG from '../db/schema';
using SBCSALESOFFICE as ENTSBCSALESOFFICE from '../db/schema';
using SBCYEAR as ENTSBCYEAR from '../db/schema';
using SBCBEZEI as ENTSBCBEZEI from '../db/schema';
using SBCBEZEIAUART as ENTSBCBEZEIAUART from '../db/schema';
using SBCPLANTNAME as ENTSBCPLANTNAME from '../db/schema';

service SALES {
    // ℹ️ Ivoice History Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity INVOICEHISTORY as projection on ENTINVOICEHISTORY;
    entity IHCUSTOMER as projection on ENTIHCUSTOMER;
    entity IHSHIPTO as projection on ENTIHSHIPTO;
    entity IHINVOICE as projection on ENTIHINVOICE;
    entity IHPO as projection on ENTIHPO;
    entity IHTYPE as projection on ENTIHTYPE;
    entity IHPROVINCE as projection on ENTIHPROVINCE;
    entity IHMFRNR as projection on ENTIHMFRNR;
    entity IHMFRNRNAME as projection on ENTIHMFRNRNAME;
    entity IHSALESORG as projection on ENTIHSALESORG;
    entity IHBEZEI as projection on ENTIHBEZEI;
    entity IHPLANTNAME as projection on ENTIHPLANTNAME;



    // ℹ️ Sales By Product/Customer Related Entities
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MFRNR or $user.SalesOrg = CO_VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SALESBYCURRENT as projection on ENTSALESBYCURRENT;
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.SalesOrg = CO_VKORG' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity SALESBYCURRENTWOPID as projection on ENTSALESBYCURRENTWOPID;
    entity SBCINVOICE as projection on ENTSBCINVOICE;
    entity SBCPRODDESC as projection on ENTSBCPRODDESC;
    entity SBCTYPE as projection on ENTSBCTYPE;
    entity SBCLOT as projection on ENTSBCLOT;
    entity SBCWAREHOUSE as projection on ENTSBCWAREHOUSE;
    entity SBCBILLTO as projection on ENTSBCBILLTO;
    entity SBCSHIPTO as projection on ENTSBCSHIPTO;
    entity SBCBILLTOID as projection on ENTSBCBILLTOID;
    entity SBCSHIPTOID as projection on ENTSBCSHIPTOID;
    entity SBCMFRNR as projection on ENTSBCMFRNR;
    entity SBCMFRNRNAME as projection on ENTSBCMFRNRNAME;
    entity SBCSALESORG as projection on ENTSBCSALESORG;
    entity SBCSALESOFFICE as projection on ENTSBCSALESOFFICE;
    entity SBCYEAR as projection on ENTSBCYEAR;
    entity SBCBEZEI as projection on ENTSBCBEZEI;
    entity SBCBEZEIAUART as projection on ENTSBCBEZEIAUART;
    entity SBCPLANTNAME as projection on ENTSBCPLANTNAME;
}

using CUSTOMERMASTER as ENTCUSTOMERMASTER from '../db/schema';
using KUNN2_BILLTO as ENTKUNN2_BILLTO from '../db/schema';
using KUNN2_SHIPTO as ENTKUNN2_SHIPTO from '../db/schema';
using KUNN2_BILLTONAME as ENTKUNN2_BILLTONAME from '../db/schema';
using KUNN2_SHIPTONAME as ENTKUNN2_SHIPTONAME from '../db/schema';
using CAL_CUST_STATUS as ENTCAL_CUST_STATUS from '../db/schema';
using CMSALESORG as ENTCMSALESORG from '../db/schema';

using PRICING as ENTPRICING from '../db/schema';
using PRICINGPRICEDESC as ENTPRICINGPRICEDESC from '../db/schema';
using PRICINGPRODUCTDESC as ENTPRICINGPRODUCTDESC from '../db/schema';
using PRICINGPRODUCT as ENTPRICINGPRODUCT from '../db/schema';
using PRICINGMFRNR as ENTPRICINGMFRNR from '../db/schema';
using PRICINGMFRNRNAME as ENTPRICINGMFRNRNAME from '../db/schema';
using PRICINGSALESORG as ENTPRICINGSALESORG from '../db/schema';

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
    entity KUNN2_BILLTONAME as projection on ENTKUNN2_BILLTONAME;
    entity KUNN2_SHIPTONAME as projection on ENTKUNN2_SHIPTONAME;
    entity CAL_CUST_STATUS as projection on ENTCAL_CUST_STATUS;
    entity CMSALESORG as projection on ENTCMSALESORG;




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
    entity PRICINGPRODUCT as projection on ENTPRICINGPRODUCT;
    entity PRICINGMFRNR as projection on ENTPRICINGMFRNR;
    entity PRICINGMFRNRNAME as projection on ENTPRICINGMFRNRNAME;
    entity PRICINGSALESORG as projection on ENTPRICINGSALESORG;
}

using CASHJOURNAL as ENTCASHJOURNAL from '../db/schema';
using BLARTS as ENTBLARTS from '../db/schema';
using BILL_TOS as ENTBILL_TOS from '../db/schema';
using BILL_TONAME as ENTBILL_TONAME from '../db/schema';
using FINCJMFRNR as ENTFINCJMFRNR from '../db/schema';
using FINCJMFRNRNAME as ENTFINCJMFRNRNAME from '../db/schema';
using FINCJSALESORG as ENTFINCJSALESORG from '../db/schema';
using FINCJPRCTR as ENTFINCJPRCTR from '../db/schema';

using OPENAR as ENTOPENAR from '../db/schema';
using OPENARCUSTOMER as ENTOPENARCUSTOMER from '../db/schema';
using OPENARCUSTOMERID as ENTOPENARCUSTOMERID from '../db/schema';
using OPENARMFRNR as ENTOPENARMFRNR from '../db/schema';
using OPENARMFRNRNAME as ENTOPENARMFRNRNAME from '../db/schema';
using OPENARSALESORG as ENTOPENARSALESORG from '../db/schema';

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
    entity OPENARCUSTOMERID as projection on ENTOPENARCUSTOMERID;
    entity OPENARMFRNR as projection on ENTOPENARMFRNR;
    entity OPENARMFRNRNAME as projection on ENTOPENARMFRNRNAME;
    entity OPENARSALESORG as projection on ENTOPENARSALESORG;




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
    entity BILL_TONAME as projection on ENTBILL_TONAME;
    entity FINCJMFRNR as projection on ENTFINCJMFRNR;
    entity FINCJMFRNRNAME as projection on ENTFINCJMFRNRNAME;
    entity FINCJSALESORG as projection on ENTFINCJSALESORG;
    entity FINCJPRCTR as projection on ENTFINCJPRCTR;
}

using MAINPAGESUMMARY as ENTMAINPAGESUMMARY from '../db/schema';
using MPSYEAR as ENTMPSYEAR from '../db/schema';
using MPSMONTH as ENTMPSMONTH from '../db/schema';
using MPSMFRNR as ENTMPSMFRNR from '../db/schema';
using MAINPAGEINVENTORY as ENTMAINPAGEINVENTORY from '../db/schema';

service MAINPAGE {
    // ⚠️ CDS Authorization Pending
    entity MAINPAGESUMMARY as projection on ENTMAINPAGESUMMARY;
    entity MPSYEAR as projection on ENTMPSYEAR;
    entity MPSMONTH as projection on ENTMPSMONTH;
    entity MPSMFRNR as projection on ENTMPSMFRNR;
    // ⚠️ CDS Authorization Pending
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '$user.ManufacturerNumber = MANUFACTURER_MFRPN' },
        { grant: 'READ', to: 'Internal' }
    ]
    entity MAINPAGEINVENTORY as projection on ENTMAINPAGEINVENTORY;


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
    @requires: 'authenticated-user'
    @restrict: [
        { grant: 'READ', to: 'Viewer', where: '($user.ManufacturerNumber = manufacturerNumber)' },
        { grant: ['READ', 'WRITE'], to: 'Internal' }
    ]

    entity MediaFile as projection on ENTMediaFile {
        ID,
        fileName,
        manufacturerNumber,
        MFGName,
        mediaType,
        content,
        createdAt,    // <<<<<<< ADD THIS LINE
        modifiedAt,
        createdBy, // Optional: add if you need to display these
        modifiedBy, // Optional: add if you need to display these
        url
    };
}

annotate Media.MediaFile with @odata.draft.enabled: true;


