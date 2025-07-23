// srv/utils/filterUtils.js

// IMPORTANT: DO NOT require('@sap/cds') here.
// The 'cds' object with its 'ql' (Query Language) capabilities will be passed in from the service handler.

/**
 * Recursively transforms filter conditions to be case-insensitive.
 * This function works for simple 'eq' and 'like' (Contains/StartsWith/EndsWith) operations.
 * For complex nested filters, this might need further refinement.
 *
 * @param {object} filter The filter object from the CDS query.
 * @param {string[]} fieldsToLowerCase An array of field names that should be treated case-insensitively.
 * @param {object} ql The cds.ql object from the calling service, used for building query expressions.
 * @returns {object} The transformed filter object.
 */
function transformFilterToCaseInsensitive(filter, fieldsToLowerCase, ql) {
    if (!filter) {
        return filter;
    }

    // Handle logical operators (AND, OR) recursively
    if (filter.and) {
        // Recursively call for each sub-filter, passing ql down
        filter.and = filter.and.map(f => transformFilterToCaseInsensitive(f, fieldsToLowerCase, ql));
    }
    if (filter.or) {
        // Recursively call for each sub-filter, passing ql down
        filter.or = filter.or.map(f => transformFilterToCaseInsensitive(f, fieldsToLowerCase, ql));
    }

    // Handle simple filter conditions (e.g., { ref: ['FieldName'], op: '=', val: 'Value' })
    // Check if it's a field reference AND if that field is in our list for case-insensitivity
    if (filter.ref && fieldsToLowerCase.includes(filter.ref[0])) {
        // Check if the value being compared is a string
        if (typeof filter.val === 'string') {
            const fieldName = filter.ref[0];
            const operator = filter.op;
            const value = filter.val;

            // *** CRITICAL PART: Use the passed 'ql' object to build expressions ***
            // 1. Create a reference to the field: ql.ref(fieldName)
            // 2. Apply the LOWER function to that field reference: ql.lower(...)
            const lowercasedFieldRef = ql.lower(ql.ref(fieldName));

            switch (operator) {
                case '=': // Equal operator (from direct comparison)
                case 'eq': // OData 'eq' operator
                    return {
                        xpr: [lowercasedFieldRef, '=', value.toLowerCase()]
                    };
                case 'like': // SQL 'LIKE' operator (often used for OData 'contains', 'startswith', 'endswith')
                    return {
                        xpr: [lowercasedFieldRef, 'like', value.toLowerCase()]
                    };
                // If you encounter other operators (e.g., 'ge', 'le') for string fields
                // and they need case-insensitivity, you might add them here, but
                // typically 'eq' and 'like' are the main ones for textual search.
                default:
                    // For any other operator or unhandled case, return the filter as is
                    // to avoid breaking other query types.
                    return filter;
            }
        }
    }
    // If it's not a relevant filter (e.g., numeric comparison, or not in fieldsToLowerCase),
    // return it unchanged.
    return filter;
}

// Export the function so it can be imported and used in other files.
// It's exported as an object property so you'll destructure it when importing.
module.exports = {
    transformFilterToCaseInsensitive
};