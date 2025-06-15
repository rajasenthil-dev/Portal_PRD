//@ui5-bundle logo/Component-preload.js
sap.ui.require.preload({
	"logo/Component.js":function(){
sap.ui.define(["sap/ui/core/UIComponent","logo/model/models"],(e,t)=>{"use strict";return e.extend("logo.Component",{metadata:{manifest:"json",interfaces:["sap.ui.core.IAsyncContentCreation"]},init(){e.prototype.init.apply(this,arguments);this.setModel(t.createDeviceModel(),"device");this.getRouter().initialize()}})});
},
	"logo/controller/App.controller.js":function(){
sap.ui.define(["sap/ui/core/mvc/Controller"],e=>{"use strict";return e.extend("logo.controller.App",{onInit(){}})});
},
	"logo/controller/View1.controller.js":function(){
sap.ui.define(["sap/ui/core/mvc/Controller"],e=>{"use strict";return e.extend("logo.controller.View1",{onInit(){var e=this.getOwnerComponent().getModel();console.log(e);var o=e.bindList("/MediaFile");console.log(o);var t=o.requestContexts();console.log(t);o.requestContexts().then(function(e){if(e.length>0){var o=e[0].getObject();console.log("Manufacturer:",o.MFGName);console.log("File URL:",o.url);var t=sap.ui.require.toUrl("logo").split("/resources")[0];if(t==="."){t=" "}console.log("✅ Dynamic Base Path:",t);var l=t+o.url;this.getView().byId("logoImage").setSrc(l)}else{console.log("No media found for this manufacturer.")}}.bind(this))}})});
},
	"logo/i18n/i18n.properties":'# This is the resource bundle for logo\n\n#Texts for manifest.json\n\n#XTIT: Application name\nappTitle=Logo\n\n#YDES: Application description\nappDescription=An SAP Fiori application.\n#XTIT: Main view title\ntitle=Logo',
	"logo/manifest.json":'{"_version":"1.65.0","sap.app":{"id":"logo","type":"application","i18n":"i18n/i18n.properties","applicationVersion":{"version":"0.0.1"},"title":"{{appTitle}}","description":"{{appDescription}}","resources":"resources.json","sourceTemplate":{"id":"@sap/generator-fiori:basic","version":"1.16.5","toolsId":"ab235fba-215b-4887-a3c2-cda98d181e60"},"dataSources":{"mainService":{"uri":"odata/v4/media/","type":"OData","settings":{"annotations":[],"odataVersion":"4.0"}}}},"sap.ui":{"technology":"UI5","icons":{"icon":"","favIcon":"","phone":"","phone@2":"","tablet":"","tablet@2":""},"deviceTypes":{"desktop":true,"tablet":true,"phone":true}},"sap.ui5":{"flexEnabled":true,"dependencies":{"minUI5Version":"1.133.0","libs":{"sap.m":{},"sap.ui.core":{}}},"contentDensities":{"compact":true,"cozy":true},"models":{"i18n":{"type":"sap.ui.model.resource.ResourceModel","settings":{"bundleName":"logo.i18n.i18n"}},"":{"dataSource":"mainService","preload":true,"settings":{"operationMode":"Server","autoExpandSelect":true,"earlyRequests":true}}},"resources":{"css":[{"uri":"css/style.css"}]},"routing":{"config":{"routerClass":"sap.m.routing.Router","controlAggregation":"pages","controlId":"app","transition":"slide","type":"View","viewType":"XML","path":"logo.view"},"routes":[{"name":"RouteView1","pattern":"","target":["TargetView1"]}],"targets":{"TargetView1":{"id":"View1","name":"View1"}}},"rootView":{"viewName":"logo.view.App","type":"XML","id":"App"}},"sap.cloud":{"public":true,"service":"mck.portal"}}',
	"logo/model/models.js":function(){
sap.ui.define(["sap/ui/model/json/JSONModel","sap/ui/Device"],function(e,n){"use strict";return{createDeviceModel:function(){var i=new e(n);i.setDefaultBindingMode("OneWay");return i}}});
},
	"logo/view/App.view.xml":'<mvc:View controllerName="logo.controller.App"\n    displayBlock="true"\n    xmlns:mvc="sap.ui.core.mvc"\n    xmlns="sap.m"><App id="app"></App></mvc:View>',
	"logo/view/View1.view.xml":'<mvc:View controllerName="logo.controller.View1"\n    xmlns:mvc="sap.ui.core.mvc"\n    xmlns="sap.m"><Image width="100%" id="logoImage" src=""/></mvc:View>'
});
//# sourceMappingURL=Component-preload.js.map
