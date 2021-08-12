const mongoose = require("mongoose");
const user = require("./user");
const MSchema = mongoose.Schema;
mongoose.set("useFindAndModify", false);

const entrySchema = new MSchema({
  title: String,
  description: String,
  date: Date.now(),
  userId: String
});
module.exports = mongoose.model("Entry", entrySchema);
