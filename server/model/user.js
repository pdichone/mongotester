const mongoose = require("mongoose");
const { getQueryType } = require("../schema/schema");
const MSchema = mongoose.Schema;
mongoose.set("useFindAndModify", false);

const userSchema = new MSchema({
  name: String,
  age: Number,
  profession: String,
});
// userSchema.pre("updateMany", function (next) {
//   this.model("User").updateMany(
//     {},
//     { $pull: { posts: this._id } },
//     { $pull: { hobbies: this._id } },
//     { mult: true },
//     next
//   );
// });
// userSchema.pre('deleteOne', { document: true}, (next) => {
//   console.log(this);
//   next();
// });
//https://stackoverflow.com/questions/11904159/automatically-remove-referencing-objects-on-deletion-in-mongodb
// userSchema.pre("deleteOne", (next) => {
//   const userId = getQueryType.userId;
//   mongoose.model(hobby).deleteMany({ userId: userId }, (err, result) => {
//     if (err) {
//       console.log(`[error] ${error}`);
//       next(err);
//     } else {
//       console.log("success");
//       next();
//     }
//   });
// });

module.exports = mongoose.model("User", userSchema);
