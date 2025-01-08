
service VDSP {
    // First Initial Test Service
}

// Processing Service
using RETURNS as ENTRETURNS from '../db/schema';
using RETCUST as ENTRETCUST from '../db/schema';
using RETRGA as ENTRETRGA from '../db/schema';
using RETREASON as ENTRETREASON from '../db/schema';


using SHIPPINGHISTORY as ENTSHIPPINGHISTORY from '../db/schema';
using SHINVOICE as ENTSHINVOICE from '../db/schema';
using SHCUSTOMER as ENTSHCUSTOMER from '../db/schema';
using SHCARRIER as ENTSHCARRIER from '../db/schema';
using SHTRACKING as ENTTRACKING from '../db/schema';
using SHSHIPTO as ENTSHSHIPTO from '../db/schema';

using BACKORDERS as ENTBACKORDERS from '../db/schema';
using BOPRODUCTDESC as ENTBOPRODUCTDESC from '../db/schema';
using BOSHIPTO as ENTBOSHIPTO from '../db/schema';
using BOBILLTO as ENTBOBILLTO from '../db/schema';

using OPENORDERS as ENTOPENORDERS from '../db/schema';
using OOPRODDESC as ENTOOPRODDESC from '../db/schema';
using OOCUST as ENTOOCUST from '../db/schema';
using OOSHIPTO as ENTOOSHIPTO from '../db/schema';
using OOPROVINCE as ENTOOPROVINCE from '../db/schema';


service PROCESSING {
    // Returns Related Entities
    entity RETURNS as projection on ENTRETURNS;
    entity RETCUST as projection on ENTRETCUST;
    entity RETRGA as projection on ENTRETRGA; 
    entity RETREASON as projection on ENTRETREASON;

    // Shipping History Related Entities
    entity SHIPPINGHISTORY as projection on ENTSHIPPINGHISTORY;
    entity SHINVOICE as projection on ENTSHINVOICE;
    entity SHCUSTOMER as projection on ENTSHCUSTOMER;
    entity SHCARRIER as projection on ENTSHCARRIER;
    entity SHTRACKING as projection on ENTTRACKING;
    entity SHSHIPTO as projection on ENTSHSHIPTO;

    //Open Orders Related Entities
    entity OPENORDERS as projection on ENTOPENORDERS;
    entity OOPRODDESC as projection on ENTOOPRODDESC;
    entity OOSHIPTO as projection on ENTOOSHIPTO;
    entity OOCUST as projection on ENTOOCUST;
    entity OOPROVINCE as projection on ENTOOPROVINCE;
    // Back Orders Related Entities
    entity BACKORDERS as projection on ENTBACKORDERS;
    entity BOBILLTO as projection on ENTBOBILLTO;
    entity BOSHIPTO as projection on ENTBOSHIPTO;
    entity BOPRODUCTDESC as projection on ENTBOPRODUCTDESC;
}

using INVENTORYAUDITTRAIL as ENTINVENTORYAUDITTRAIL from '../db/schema';
using IATPRODUCTCODE as ENTIATPRODUCTCODE from '../db/schema';
using IATLOT as ENTIATLOT from '../db/schema';
using IATWAREHOUSE as ENTIATWAREHOUSE from '../db/schema';
using IATCUSTSUPP as ENTIATCUSTSUPP from '../db/schema';

using INVENTORYSTATUS as ENTINVENTORYSTATUS from '../db/schema';
using INVSTATUSPRODUCTCODE as ENTINVSTATUSPRODUCTCODE from '../db/schema';

using INVENTORYBYLOT as ENTINVENTORYBYLOT from '../db/schema';
using INVBYLOTPRODUCTCODE as ENTINVBYLOTPRODUCTCODE from '../db/schema';
using INVBYLOTLOT as ENTINVBYLOTLOT from '../db/schema';
using INVBYLOTWAREHOUSE as ENTINVBYLOTWAREHOUSE from '../db/schema';

using INVENTORYSNAPSHOT as ENTINVENTORYSNAPSHOT from '../db/schema';
using INVSNAPPRODDESC as ENTINVSNAPPRODDESC from '../db/schema';
using INVSNAPLOT as ENTINVSNAPLOT from '../db/schema';
using INVSNAPWARESTAT as ENTINVSNAPWARESTAT from '../db/schema';

using INVENTORYVALUATION as ENTINVENTORYVALUATION from '../db/schema';
using INVVALPRODDESC as ENTINVVALPRODDESC from '../db/schema';
using INVVALPROD as ENTINVVALPROD from '../db/schema';

using ITEMMASTER as ENTITEMMASTER from '../db/schema';
using ITEMMASPD as ENTITEMMASPD from '../db/schema';
using ITEMMASCATEGORY as ENTITEMMASCATEGORY from '../db/schema';




service INVENTORY {
    // Inventory Audit Trail Related Entities
    entity INVENTORYAUDITTRAIL as projection on ENTINVENTORYAUDITTRAIL; 
    entity IATPRODUCTCODE as projection on ENTIATPRODUCTCODE;
    entity IATLOT as projection on ENTIATLOT;
    entity IATWAREHOUSE as projection on ENTIATWAREHOUSE;
    entity IATCUSTSUPP as projection on ENTIATCUSTSUPP;

    // Inventory Valuation Related Entities
    entity INVENTORYVALUATION as projection on ENTINVENTORYVALUATION;
    entity INVVALPRODDESC as projection on ENTINVVALPRODDESC;
    entity INVVALPROD as projection on ENTINVVALPROD;

    // Inventory Status Related Entities
    entity INVENTORYSTATUS as projection on ENTINVENTORYSTATUS;
    entity INVSTATUSPRODUCTCODE as projection on ENTINVSTATUSPRODUCTCODE;

    // Inventory By Lot Related Entities
    entity INVENTORYBYLOT as projection on ENTINVENTORYBYLOT;
    entity INVBYLOTPRODUCTCODE as projection on ENTINVBYLOTPRODUCTCODE;
    entity INVBYLOTLOT as projection on ENTINVBYLOTLOT;
    entity INVBYLOTWAREHOUSE as projection on ENTINVBYLOTWAREHOUSE;

    // Item Master Related Entities
    entity ITEMMASTER as projection on ENTITEMMASTER;
    entity ITEMMASPD as projection on ENTITEMMASPD;
    entity ITEMMASCATEGORY as projection on ENTITEMMASCATEGORY;

    // Lot Inventory Snapshot Related Entities 
    entity INVENTORYSNAPSHOT as projection on ENTINVENTORYSNAPSHOT;
    entity INVSNAPPRODDESC as projection on ENTINVSNAPPRODDESC;
    entity INVSNAPLOT as projection on ENTINVSNAPLOT;
    entity INVSNAPWARESTAT as projection on ENTINVSNAPWARESTAT;
}

using INVOICEHISTORY as ENTINVOICEHISTORY from '../db/schema';
using IHCUSTOMER as ENTIHCUSTOMER from '../db/schema';
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

    // Ivoice History Related Entities
    entity INVOICEHISTORY as projection on ENTINVOICEHISTORY;
    entity IHCUSTOMER as projection on ENTIHCUSTOMER;
    entity IHSHIPTO as projection on ENTIHSHIPTO;
    entity IHINVOICE as projection on ENTIHINVOICE;
    entity IHPO as projection on ENTIHPO;
    entity IHTYPE as projection on ENTIHTYPE;
    entity IHPROVINCE as projection on ENTIHPROVINCE;


    // Sales By Product/Customer Related Entities
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
    // Customer Listing Related Entities
    entity CUSTOMERMASTER as projection on ENTCUSTOMERMASTER;
    entity KUNN2_BILLTO as projection on ENTKUNN2_BILLTO;
    entity KUNN2_SHIPTO as projection on ENTKUNN2_SHIPTO;
    entity CAL_CUST_STATUS as projection on ENTCAL_CUST_STATUS;

    // Pricing Related Entities
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
    // Accounts Receivable Related Entities
    entity OPENAR as projection on ENTOPENAR;
    entity OPENARCUSTOMER as projection on ENTOPENARCUSTOMER;

    // Cash Journal Related Entities
    entity CASHJOURNAL as projection on ENTCASHJOURNAL;
    entity BLARTS as projection on ENTBLARTS;
    entity BILL_TOS as projection on ENTBILL_TOS;
}

using MAINPAGESUMMARY as ENTMAINPAGESUMMARY from '../db/schema';
using MAINPAGEINVENTORY as ENTMAINPAGEINVENTORY from '../db/schema';

service MAINPAGE {
    entity MAINPAGESUMMARY as select from ENTMAINPAGESUMMARY {
        sum(UNIT_SHIPPED) as UNIT_SHIPPED,
        sum(TOTAL_SALES_AMOUNT) as TOTAL_SALES_AMOUNT,
        sum(INVOICES) as INVOICES
    }
    
    entity MAINPAGEINVENTORY as projection on ENTMAINPAGEINVENTORY;
} 

service CatalogService {
    @readonly entity Invoices {
        key ID: UUID;
        InvoiceNumber: String;
    }
}







    
    