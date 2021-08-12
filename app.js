const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

var { graphqlHTTP } = require("express-graphql");
const schema = require("./server/schema/schema");

const graphqlSchema = require("./server/schema/prodSchema");
const graphqlResolver = require("./resolvers");

var root = { hello: () => "Hello world!" };

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
    app.listen({ port: 3000 }, () => {
      console.log("Your Apollo Server is running on port 3000");
    });
  });
