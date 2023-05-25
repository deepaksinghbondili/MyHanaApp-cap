/* eslint-disable no-empty */
{ }/* eslint-disable no-unused-vars */
/* eslint-disable no-undef */
sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";
        var that;
        return Controller.extend("fiori.crudapp.controller.Home", {
            onInit: function () {
                that = this;

                if (!that.oCreateDialog) {
                    that.oCreateDialog = sap.ui.xmlfragment("fiori.crudapp.fragments.Create", that);
                    that.getView().addDependent(that.oCreateDialog);
                }
            },
            onAfterRendering: function () {
                var oModel = that.getOwnerComponent().getModel("oModel");
                oModel.read("/OrgSet", {
                    success: function (oData) {
                        var model = new sap.ui.model.json.JSONModel();
                        var oTable = that.getView().byId("idTable");
                        model.setData({
                            items: oData.results
                        });
                        oTable.setModel(model);

                    },
                    error: function (error) {
                        sap.m.MessageToast().show(error);
                    }
                });
            },
            onToggleFooter: function () {
                var page = this.byId("dynamicPageId");
                page.setShowFooter(!page.getShowFooter());
            },
            onCreate: function (oEvent) {
                that.oCreateDialog.open();
            },
            onClose: function () {
                that.oCreateDialog.close();
                that.clear();
            },
            clear: function () {
                sap.ui.getCore().byId("idEmp").setValue("");
                sap.ui.getCore().byId("idName").setValue("");
                sap.ui.getCore().byId("idNum").setValue("");
                sap.ui.getCore().byId("idCity").setValue("");
            },
            onSave: function (oEvent) {
                var id = sap.ui.getCore().byId("idEmp").getValue();
                var name = sap.ui.getCore().byId("idName").getValue();
                var phone = sap.ui.getCore().byId("idNum").getValue();
                var city = sap.ui.getCore().byId("idCity").getValue();
                var obj = {
                    EmployeeID: id,
                    EmployeeName: name,
                    Phone: phone,
                    City: city
                };

                var oModel = that.getOwnerComponent().getModel("oModel");
                oModel.callFunction("/validate", {
                    method: "GET",
                    urlParameters: {
                        Obj: JSON.stringify(obj)
                    },
                    success: function (oData, _response) {
                        var message = _response.data.validate.message;
                        sap.m.MessageToast.show(message);
                        that.clear();
                        that.oCreateDialog.close();
                        that.onAfterRendering();
                    },
                    error: function (e) {
                        sap.m.MessageToast.show(e);
                    }
                })
            },

            onDelete: function (oEvent) {

            },

            onEdit: function (oEvent) {
                that.oCreateDialog.open();
                var oTable = that.getView().byId("idTable");
                sap.ui.getCore().byId("idEmp").setValue(oEvent.getSource().getParent().getCells()[0].getText());
                sap.ui.getCore().byId("idName").setValue(oEvent.getSource().getParent().getCells()[1].getText());
                sap.ui.getCore().byId("idNum").setValue(oEvent.getSource().getParent().getCells()[2].getText());
                sap.ui.getCore().byId("idCity").setValue(oEvent.getSource().getParent().getCells()[3].getText());
            },

            onSearch: function (oEvent) {

            }
        });
    });