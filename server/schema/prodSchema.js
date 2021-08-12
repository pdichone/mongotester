//const { buildSchema } = require("graphql");

var {
  buildSchema,
  GraphQLObjectType,
  GraphQLID,
  GraphQLString,
  GraphQLInt,
  GraphQLSchema,
} = require("graphql");
const moment = require("moment");
const product = require("../model/product");

//rootquery
const RootQuery = new GraphQLObjectType({
  name: "rootquery",
  description: "The actual rootquery",
  fields: {
    prod: {
      type: product,
      args: {
        id: {
          type: GraphQLInt,
        },
      },
      resolve(parent, args) {
        //get and return data from the data source

        return {
          id: "1",
          name: "Paulo",
        };
      },
    },
  },
});
module.exports = new GraphQLSchema({
  query: RootQuery,
});

buildSchema(`
    type Product{
        _id:ID!
        name: String!
        description: String!
        price: Float!
        discount: Int
        created_at: String!
        updated_at: String!
    }    
    type ProductData {
        products: [Product!]!
    }
    input ProductInputData {
        name: String!
        description: String!
        price: Float!
        discount: Int
    }
    type RootQuery {
        products: ProductData!
    }
    type RootMutation {
        createProduct(productInput:ProductInputData): Product!
        updateProduct(id: ID!, productInput:ProductInputData): Product!
        deleteProduct(id: ID!): Product!
    }
    schema {
        query: RootQuery
        mutation: RootMutation
    }
`);
