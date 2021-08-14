const mongoose = require("mongoose");
const entry = require("./entry");
const MSchema = mongoose.Schema;
mongoose.set("useFindAndModify", false);

const entrySchema = new MSchema({
  
  title: String,
  description: String,
  date: Date, //mongoose Date
  userId: String,
});
module.exports = mongoose.model("Entry", entrySchema);
