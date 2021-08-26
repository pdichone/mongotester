const mongoose = require("mongoose");
const { getQueryType } = require("../schema/schema");
const MSchema = mongoose.Schema;
mongoose.set("useFindAndModify", false);

const userSchema = new MSchema({
  name: String,
  age: Number,
  profession: String,
});

module.exports = mongoose.model("User", userSchema);
