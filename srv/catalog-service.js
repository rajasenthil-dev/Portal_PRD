const cds = require('@sap/cds');

module.exports = async (srv) => {
    srv.before('READ', 'MediaFile', async (req) => {
        let userManufacturerNumber = req.user.attr.ManufacturerNumber;

        if (!userManufacturerNumber) {
            req.query.where({ ManufacturerNumber: null });
        }
    })
}