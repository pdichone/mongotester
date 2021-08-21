const mongoose = require("mongoose");
const MSchema = mongoose.Schema;

const hobbySchema = new MSchema({
  name: { type: String },
  person: { type: mongoose.Schema.Types.ObjectId, ref: "Hobby" },
  title: String,
  description: String,
  userId: String,
});
module.exports = mongoose.model("Hobby", hobbySchema);
