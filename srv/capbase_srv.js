const cds = require("@sap/cds");
module.exports = srv => {
    srv.before("validate", async (req) => {
        debugger;
        console.log("This is before validate function execution");
    });
    srv.on("validate", async (req, res) => {
        try {
            debugger;
            const obj = JSON.parse(req.data.Obj);
            await cds.run(INSERT.into("DB_ORGANIZATION").entries(obj));
            const result = { message: "Successfully Created " }
            return result;
        } catch (error) {
            console.error(error);
            return error;
        }
    });
    srv.after("validate", res => {
        debugger;
        console.error("This is after validate function is completed");
    });
};