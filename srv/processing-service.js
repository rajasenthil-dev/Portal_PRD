const cds = require('@sap/cds');

module.exports = async (srv) => {
    srv.on('calculateTotals', async (req) => {
        const { entityName, filters } = req.data;
    
        // Validate the entity name
        if (!['OPENORDERS'].includes(entityName)) {
            req.error(400, `Invalid entity name: ${entityName}`);
        }
    
        const tableName = entityName === 'OPENORDERS' ? 'OPENORDERS' : 'OPENORDERS';
        const filterConditions = JSON.parse(filters);
    
        // Build the dynamic query
        const query = SELECT.from(tableName)
            .columns(
                'COUNT(*) as totalOpenLines',
                'SUM(KWMENG) as totalKWMENG'
            )
            .where(filterConditions);
    
        const results = await cds.run(query);
        return results[0];
    });
};