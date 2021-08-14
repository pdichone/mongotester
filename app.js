const express = require("express");
const mongoose = require("mongoose");

const cors = require("cors");
const port = process.env.PORT || 4000;
var { graphqlHTTP } = require("express-graphql");
const schema = require("./server/schema/schema");

var app = express();
app.use(
  "/graphql",
  graphqlHTTP({
    //schema: graphqlSchema,
    //rootValue: graphqlResolver,
    schema: schema,
    //rootValue: root,
    graphiql: true,
  })
);

mongoose
  .connect(
    `mongodb+srv://${process.env.mongoUserName}:${process.env.mongoUserPassword}@cluster0.wlrms.mongodb.net/${process.env.mongoDatabase}?retryWrites=true&w=majority`,
    { useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true }
  )
  .then(() => {
    app.listen({ port: port }, () => {
      console.log("Your Apollo Server is running on port" + port);
    });
  });
