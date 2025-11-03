sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageToast",
    "sap/m/MessageBox",
    "sap/f/library",
    "sap/ui/core/Core" // Required for BusyIndicator
], function (Controller, MessageToast, MessageBox, fioriLibrary, Core) {
    "use strict";
    return Controller.extend("accessmanager1.controller.Detail", {
        onInit: function () {
            var oOwnerComponent = this.getOwnerComponent();

            this.oRouter = oOwnerComponent.getRouter();
            this.oModel = oOwnerComponent.getModel();
            // ✅ Create an edit model with a default non-editable state
            const oViewModel = new sap.ui.model.json.JSONModel({
                isEdit: false,
                showFooter: false
            });
            this.getView().setModel(oViewModel, "viewState");
          
          

          this.oRouter.getRoute("master").attachPatternMatched(this._onProductMatched, this);
          this.oRouter.getRoute("detail").attachPatternMatched(this._onProductMatched, this);
        },

        _onProductMatched: function (oEvent) {
          this._product= oEvent.getParameter("arguments").product || this._product || "0";
          var sObjectPath = "/" + this._product;
          this.getView().bindElement({
            path: sObjectPath,
            model: "edit"
          });
          
        },

        onEditToggleButtonPress: function() {
          var oObjectPage = this.getView().byId("ObjectPageLayout"),
            bCurrentShowFooterState = oObjectPage.getShowFooter();

          oObjectPage.setShowFooter(!bCurrentShowFooterState);
          const oViewModel = this.getView().getModel("viewState");
          const bEditable = !oViewModel.getProperty("/isEdit");
          oViewModel.setProperty("/isEdit", bEditable);

          sap.m.MessageToast.show(bEditable ? "Edit mode enabled" : "Edit mode disabled");
        },
        onCancel: function () {
            const oView = this.getView();
            const oObjectPage = oView.byId("ObjectPageLayout");
            const oViewModel = oView.getModel("viewState");

            // ✅ Always disable edit mode
            oViewModel.setProperty("/isEdit", false);

            // ✅ Always hide the footer
            oObjectPage.setShowFooter(false);

            // ✅ Optional: show a toast
            sap.m.MessageToast.show("Edit cancelled");
            
            this.oRouter.navTo("master", {
                layout: fioriLibrary.LayoutType.OneColumn
            });
        },
       onSave: function () {
            const oView = this.getView();
            const oODataModel = this.getOwnerComponent().getModel();
            const oRouter = this.getOwnerComponent().getRouter();
            const fioriLibrary = sap.f.library;

            const oCtx = oView.getBindingContext("edit");
            if (!oCtx) {
                return sap.m.MessageBox.error("Cannot save: No binding context.");
            }

            const oData = oCtx.getObject();
            const sPath = "/OKTAUsers('" + oData.id + "')";

            oView.setBusy(true);

            oODataModel.update(sPath, oData, {
                success: () => {
                    oView.setBusy(false);
                    sap.m.MessageToast.show("✅ User updated successfully");

                    // 🧩 1️⃣ Exit edit mode
                    this._exitEditMode?.();

                    // 🧩 2️⃣ Refresh master list once update succeeds
                    const oList = this._getMasterList?.(); // helper to access master list
                    if (oList) {
                        oList.getBinding("items").refresh(); // ensures list data updates
                    }

                    // 🧩 3️⃣ Animate collapse back to master view
                    this.oRouter.navTo("master", {
                        layout: fioriLibrary.LayoutType.OneColumn
                    });
                },
                error: (oError) => {
                oView.setBusy(false);
                console.error("❌ Save Error", oError);
                sap.m.MessageBox.error("Update failed — check input or permissions.");
                },
                merge: true
            });
        },
      //   onSave: function () {
      //     const oView = this.getView();
      //     const oObjectPage = this.byId("ObjectPageLayout");
      //     const oEditModel = this.getView().getModel("edit");
      //     const oCtx = oObjectPage.getBindingContext("edit");

      //     if (!oCtx) {
      //         sap.m.MessageBox.error("No user selected to save.");
      //         return;
      //     }

      //     // Extract updated user data
      //     const oData = oCtx.getObject();

      //     // Build OData V2 payload for backend ⇢ must match service.cds props
      //     const payload = {
      //       firstName: oData.firstName,
      //       lastName: oData.lastName,
      //       email: oData.email,
      //       mfgName: oData.mfgName,

      //       // ✅ CAP expects String for these
      //       manufacturerNumber: Array.isArray(oData.manufacturerNumber)
      //         ? oData.manufacturerNumber.join(",")
      //         : oData.manufacturerNumber || "",

      //       groupIds: Array.isArray(oData.groupIds)
      //         ? oData.groupIds.join(",")
      //         : oData.groupIds || "",

      //       salesOrg: oData.salesOrg,
      //       salesOffice: oData.salesOffice,
      //       profitCentre: oData.profitCentre,
      //     };

      //     // Determine OData path for correct user from default model
      //     const sId = encodeURIComponent(oData.id);
      //     const sPath = "/OKTAUsers('" + sId + "')";

      //     const oModel = this.getOwnerComponent().getModel(); // Default OData V2 Model
      //     oView.setBusy(true);

      //     oModel.update(sPath, payload, {
      //         success: () => {
      //             oView.setBusy(false);
      //             sap.m.MessageToast.show("User updated successfully ✅");

      //             // Refresh both models so list updates too
      //             oEditModel.refresh(true);
      //             oModel.refresh(true);

      //             // Exit edit mode + hide footer
      //             oEditModel.setProperty("/isEdit", false);
      //             oObjectPage.setShowFooter(false);
      //         },
      //         error: (oError) => {
      //             oView.setBusy(false);

      //             let sErrorMessage = "Failed to save user.";
      //             try {
      //                 const oResp = JSON.parse(oError.responseText);
      //                 sErrorMessage = oResp.error?.message?.value || oResp.error?.message || sErrorMessage;
      //             } catch (e) {}

      //             sap.m.MessageBox.error(sErrorMessage);
      //             console.error("Save error:", oError);
      //         }
      //     });
      // },
        onExit: function () {
          this.oRouter.getRoute("master").detachPatternMatched(this._onProductMatched, this);
          this.oRouter.getRoute("detail").detachPatternMatched(this._onProductMatched, this);
          
        }
	});
});