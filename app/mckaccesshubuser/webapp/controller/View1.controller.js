sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast",
    "sap/m/MessageBox",
    "sap/m/WizardStep"
], (Controller, JSONModel, MessageToast, MessageBox, WizardStep) => {
    "use strict";
    var history = {
      prevUserSelect: null
    };

    return Controller.extend("mckaccesshubuser.controller.View1", {
        onInit: function () { 
          this._wizard = this.byId("wizard");
          this._oNavContainer = this.byId("wizardNavContainer");
          this._oWizardContentPage = this.byId("wizardContentPage");
          this._initModel();
          this.model = new JSONModel();
          const selectedGroup = this.getView().getModel("userContext").getProperty("/selectedGroup");
          console.log("Selected Group:", selectedGroup);
          // Set initial properties immediately
          this.model.setProperty("/selectedUser", "InternalUser");
          this.model.setData({
              selectedUser: "InternalUser",
              editGroup: false,
              groupAction: 0, // 0 = Existing Group, 1 = New Group
              selectedGroup: "",
              firstName: "",
              lastName: "",
              email: "",
              manufacturerNumber: "",
              MFGName: "",
              profitCentre: "",
              salesOrg: "",
              salesOffice: "",
              newGroupName: "",
              groupDetails: {
                  groupList: []
              },
              internalChecklist: [
                {
                  "title": "Create a ServiceNow Request",
                  "description": "Use the 'AD Group Membership' request type."
                },
                {
                  "title": "Enter User's Info",
                  "description": "Name, email, and whether they are a new hire or transfer."
                },
                {
                  "title": "Select Correct AD Group",
                  "description": "BTP_INTERNAL_USERS for NAMCK or MFG_INTERNAL_USERS_CA for CA."
                },
                {
                  "title": "Write a Clear Business Justification",
                  "description": "Why this access is needed."
                },
                {
                  "title": "Approval Path",
                  "description": "Manager → Application Owner → AD Group Admin"
                }
              ],
              approvalSteps: [
                { step: "Manager Approval", icon: "sap-icon://employee-approvals" },
                { step: "Application Owner Approval", icon: "sap-icon://user-settings" },
                { step: "AD Group Admin Adds User", icon: "sap-icon://shield" }
              ]
          });
          // Set the model on the view
          this.getView().setModel(this.model, "userContext");
          debugger
          var oOktaModel = this.getView().getModel("oktaService");

          console.log("Okta Model from View:", oOktaModel);

          if (!oOktaModel) {
              console.error("❌ OktaService model not found! Check manifest or Component.js");
              return;
          }

          oOktaModel.metadataLoaded().then(function () {
              console.log("✅ Metadata loaded successfully");
              this._loadOktaGroups();
          }.bind(this)).catch(function (err) {
              console.error("❌ Failed to load metadata:", err);
          });
          const oInstructions = this.byId("internalInstructions");
          const oInstructions1 = this.byId("internalInstructions1");
          const oExternalUserInfo = this.byId("externalUserInfo");
          const oMfgUserInfo = this.byId("mfgUserInfo");
          const oGroupUserInfo = this.byId("groupUserInfo");
          oInstructions.setHtmlText(`
            <p>This request ensures your user gets the right access securely and on time.</p>
  
            <ul>
              <li><strong>New Hire or Transfer?</strong> Pick carefully for correct approvals.</li>
              <li><strong>Domain:</strong> NAMCK (North America) or CA (Canada).</li>
              <li><strong>AD Group:</strong> BTP_INTERNAL_USERS (NA) or MFG_INTERNAL_USERS_CA (CA).</li>
              <li><strong>Business Justification:</strong> Keep it clear to avoid delays.</li>
            </ul>
    
          `);
            oInstructions1.setHtmlText(`
              <ol>
                <li>Manager reviews</li>
                <li>Application Owner approves</li>
                <li>AD Group Admin adds the user</li>
              </ol>
              <p class="tipText"><strong>Tip: </strong>More Info = <em>Faster Approvals</em></p>
            `);
            oExternalUserInfo.setHtmlText(`
              <p>Please enter accurate details for the external user. These will be <strong>provisioned to Okta</strong> and may affect downstream systems.</p>
              <ul>
                <li><strong>Names</strong> should be spelled exactly as per official documentation.</li>
                <li><strong>Email</strong> must be a valid, active partner address.</li>
              </ul>
              <p class="tipText"><strong>Tip:</strong> Double-check the email for typos. Approval and access links go here!</p>
            `);
            oMfgUserInfo.setHtmlText(`
              <p>Please enter accurate <strong>manufacturer details</strong>. These are used to filter the user’s data access in the system.</p>
              <ul>
                <li>Manufacturer Number & Name must match internal records exactly.</li>
                <li>Profit Center, Sales Org, and Sales Office affect data visibility and reporting.</li>
              </ul>
              <p class="tipText"><strong>Tip:</strong> These values will be validated via backend filters and CDS authorizations, so accuracy is crucial.</p>
            `);
            oGroupUserInfo.setHtmlText(`
              <p><strong>User groups</strong> define what applications and data the user can access in the Build Work Zone.</p>
              <ul>
                <li>Prefer existing groups to keep things clean and consistent.</li>
                <li>If creating a new group, choose a clear, descriptive name.</li>
                <li>Groups are managed centrally and tied to application roles.</li>
              </ul>
              <p class="tipText"><strong>Tip:</strong> Reach out to your admin team before creating a new group — there may already be one that fits your need!</p>`
            );
    
                //this.model.loadData(sap.ui.require.toUrl("sap/ui/demo/mock/products.json"));
                this.getView().setModel(this.model);
            // sample JSON data for testing
            // const oData = {
            //   userType: "Internal",
            //   userDetails: {
            //     firstName: "",
            //     lastName: "",
            //     email: "",
            //     manufacturerNumber: "",
            //     manufacturerName: "",
            //     profitCenter: "",
            //     salesOrg: "",
            //     salesOffice: "",
            //     group: ""
            //   },
            //   summary: {}
            // };
    
            // // attach JSON model
            // const oModel = new JSONModel(oData);
            // this.getView().setModel(oModel);
    
            // set default instructions
          //   this.byId("instructionText").setHtmlText(`
          //     <ul>
          //       <li>Select the user type to continue.</li>
          //     </ul>
          //   `);
            let oModel = this.getView().getModel("userContext");
    
            oModel.setProperty("/editUserDetails", false);
            oModel.setProperty("/editManufacturerDetails", false);
            oModel.setProperty("/editGroup", false);
          },
          onBeforeRendering: function () {
            if (!this._groupsLoaded) {
                this._loadOktaGroups();
                this._groupsLoaded = true;
            }
          },
          _loadOktaGroups: function () {
            var oView = this.getView();
            var oUserModel = oView.getModel("userContext");
            var oOktaModel = oView.getModel("oktaService");

            // Check if model is available
            if (!oUserModel) {
                console.error("userContext model not found. Did you set it in onInit?");
                return;
            }

            var oAction = oOktaModel.bindContext("/getOktaGroups(...)");

            oAction.execute()
                .then(function () {
                    var aGroups = oAction.getBoundContext().getObject();
                    console.log("Fetched Groups:", aGroups);
                    debugger
                    oUserModel.setProperty("/groupDetails/groupList", aGroups);

                    // Optionally select first group by default
                    if (aGroups.length) {
                        oUserModel.setProperty("/selectedGroup", aGroups[2].id);
                    }

                    oUserModel.updateBindings(true); // Force UI refresh if needed
                })
                .catch(function (oError) {
                    console.error("Error fetching groups:", oError);
                    sap.m.MessageBox.error("Failed to fetch Okta groups.");
                });
          },
          goToUserStep: function () {
            debugger
            var selectedKey = this.model.getProperty("/selectedUser");
    
            switch (selectedKey) {
              case "ExternalUser":
                this.byId("UserTypeStep").setNextStep(this.getView().byId("stepExternalDetails"));
                break;
                case "InternalUser":
                  default:
                  this.byId("UserTypeStep").setNextStep(this.getView().byId("stepInternalFinal"));
                break;
            }
          },
          setUserMethod: function () {
            this.setDiscardableProperty({
                message: "Are you sure you want to change the user type? This will discard your progress.",
                discardStep: this.byId("UserTypeStep"),
                modelPath: "/selectedUser",
                historyPath: "prevUserSelect"
            });
        },
    
        setDiscardableProperty: function (params) {
            const sCurrentSelection = this.model.getProperty(params.modelPath);
    
            if (this._wizard.getProgressStep() !== params.discardStep) {
                MessageBox.warning(params.message, {
                    actions: [MessageBox.Action.YES, MessageBox.Action.NO],
                    onClose: function (oAction) {
                        if (oAction === MessageBox.Action.YES) {
                            // ✅ Commit new selection
                            this._wizard.discardProgress(params.discardStep);
                            history[params.historyPath] = sCurrentSelection;
    
                            // ✅ Recalculate next step based on new selection
                            this.goToUserStep();
                        } else {
                            // ❌ Revert to previous selection if NO is chosen
                            this.model.setProperty(params.modelPath, history[params.historyPath]);
                        }
                    }.bind(this)
                });
            } else {
                history[params.historyPath] = sCurrentSelection;
                this.goToUserStep(); // ✅ Set correct flow immediately on first selection
            }
          },
          onWizardReview: function () {
            debugger
            const oUserContext = this.getView().getModel("userContext");
            if (!oUserContext) {
              sap.m.MessageToast.show("User context model is missing!");
              return;
            }
            const userType = oUserContext.getProperty("/selectedUser");  // or "/type" if you rename it
    
            if (userType === "InternalUser") {
              this._oNavContainer.to(this.byId("internalReviewPage"));
            } else {
              let oModel = this.getView().getModel("userContext");
    
              oModel.setProperty("/editUserDetails", false);
              oModel.setProperty("/editManufacturerDetails", false);
              oModel.setProperty("/editGroup", false);
              this._oNavContainer.to(this.byId("externalReviewPage"));
            }
          },
          onFinishInternal: function () {
            this._oNavContainer.to(this.byId("finishPage"));
          },
    
          onStartOver: function () {
            // Reset the wizard to the first step
            var oWizard = this.byId("wizard"); // Replace with your wizard ID
            this.setUserMethod();
    
            // Optionally reset models
            this.getView().getModel("userContext").setData({});
            this.byId("userMethodSelection").setSelectedKey("InternalUser");
            this._oNavContainer.to(this.byId("wizardContentPage"));
          },
    
          onExitWizard: function () {
              // Simple redirect back to Work Zone or Home Page
              window.top.location.href = "/";
              // ✅ Replace "/" with your Work Zone workspace URL if needed
          },
          onFetchGroups: function () {
            var oModel = this.getView().getModel("oktaService");
            var oAction = oModel.bindContext("/getOktaGroups(...)");
        
            oAction.setParameter("query", "MFG");
        
            var oView = this.getView();
        
            oAction.execute()
                .then(function () {
                    var aGroups = oAction.getBoundContext().getObject();
        
                    // Update the userContext model with the group list
                    var oUserContextModel = oView.getModel("userContext");
                    oUserContextModel.setProperty("/groupDetails", {
                        groupList: aGroups
                    });
                })
                .catch(function (oError) {
                    console.error("Error fetching groups:", oError);
                    sap.m.MessageBox.error("Failed to fetch Okta groups.");
                });
        },
          onSubmitOktaUser: function () {
            var oView = this.getView();
            var oUserContext = oView.getModel("userContext").getData();
        
            // ✅ Build Okta User Payload
            var oPayload = {
                user: {
                    profile: {
                        firstName: oUserContext.firstName,
                        lastName: oUserContext.lastName,
                        email: oUserContext.email,
                        login: oUserContext.email,
                        salesOffice: oUserContext.salesOffice,
                        profitCentre: oUserContext.profitCentre,
                        salesOrg: oUserContext.salesOrg,
                        manufacturerNumber: [oUserContext.manufacturerNumber],
                        mfgName: oUserContext.mfgName
                    },
                    groupIds: ["00gkmbbie9xNhlxcb1d7"]
                }
            };
        
            var oModel = this.getView().getModel("oktaService");
            var oAction = oModel.bindContext("/createOktaUser(...)");
        
            oAction.setParameter("user", oPayload.user);
        
            var that = this; // keep reference for inside the promise
        
            oAction.execute()
                .then(function () {
                    var oResponse = oAction.getBoundContext().getObject();
        
                    // ✅ Show MessageBox (with OK) & navigate to Finish Page
                    sap.m.MessageBox.success(
                        `User created successfully!\nID: ${oResponse.userId}`,
                        {
                            title: "Success",
                            onClose: function () {
                                var oNavContainer = that.byId("navContainer");
                                oNavContainer.to(that.byId("finishPage"));
                            }
                        }
                    );
                })
                .catch(function (oError) {
                    console.error("Error creating Okta user:", oError);
                    sap.m.MessageBox.error("Failed to create user in Okta.");
                });
          },
          onToggleEditUserDetails: function () {
            let oModel = this.getView().getModel("userContext");
            let bEditing = oModel.getProperty("/editUserDetails");
            oModel.setProperty("/editUserDetails", !bEditing);
          },
    
          onToggleEditManufacturerDetails: function () {
            let oModel = this.getView().getModel("userContext");
            let bEditing = oModel.getProperty("/editManufacturerDetails");
            oModel.setProperty("/editManufacturerDetails", !bEditing);
          },
    
          onToggleEditGroup: function () {
            let oModel = this.getView().getModel("userContext");
            let bEditing = oModel.getProperty("/editGroup");
            oModel.setProperty("/editGroup", !bEditing);
          },
          _initModel: function () {
            this.model = new JSONModel({
                // ✅ External user fields
                externalUserDetails: {
                    firstName: "",
                    lastName: "",
                    email: "",
                    company: "",
                    oktaProvisioning: true
                },
                // ✅ Manufacturer (only for external users if applicable)
                manufacturerDetails: {
                    manufacturerNumber: "",
                    manufacturerName: "",
                    profitCenter: "",
                    salesOrg: "",
                    salesOffice: ""
                },
                // ✅ Group selection (common for both)
                groupDetails: {
                    isNewGroup: false,
                    groupList: [
                      "MFG_Reports_Internal",
                      "MFG_Reports_All",
                      "MFG_Reports_NoPricing",
                      "MFG_Reports_NoCashJournal",
                      "MFG_Reports_NoInvoiceHistory",
                      "MFG_Reports_NoBackOrder",
                      "MFG_Reports_NoBKO_NoFinance",
                      "MFG_Reports_NoFinance_NoInvoiceHistory",
                      "MFG_Reports_NoFinance_NoInvoiceHistory_NoBKO",
                      "MFG_Reports_NoAllocation",
                      "MFG_Reports_NoPatientId",
                      "MFG_Admin",
                      "MFG_Cards_NoSalesBy",
                      "MFG_Reports_NoFinance",
                      "MFG_Reports_All_PivotTable",
                      "MFG_Reports_NoFinance_NoInvoiceHistory_NoReturn_NoShipping_RC",
                      "MFG_Reports_NoCashJournal_NoReturn_NoShipping",
                      "MFG_Reports_BuySell"
                  ],
                  selectedGroup: "" // store selected group
                }
            });
    
            this.getView().setModel(this.model, "userContext");
        }
    
    });
});