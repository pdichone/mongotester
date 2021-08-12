var {
  buildSchema,
  GraphQLObjectType,
  GraphQLID,
  GraphQLString,
  GraphQLInt,
  GraphQLNonNull,
  GraphQLSchema,
} = require("graphql");

const moment = require("moment");
const User = require("../model/user");

const UserType = new GraphQLObjectType({
  name: "User",
  description: "This is just testing...",
  fields: () => ({
    id: { type: GraphQLID },
    name: { type: GraphQLString },
    age: { type: GraphQLInt },
    profession: { type: GraphQLString },
    // date: {
    //   type: GraphQLString,
    //   default: Date.now(),
    // },
  }),
});

const EntryType = new GraphQLObjectType({
  name: "Entry",
  description: "Entry - diary entry",
  fields: () => ({
    title: { type: GraphQLString },
    description: { type: GraphQLString },
    date: { type: GraphQLString, default: Date.now() },
    profession: { type: GraphQLString },
  }),
});

//rootquery
const RootQuery = new GraphQLObjectType({
  name: "rootquery",
  description: "The actual rootquery",
  fields: {
    user: {
      type: UserType,
      args: {
        id: {
          type: GraphQLInt,
        },
      },
      resolve(parent, args) {
        //get and return data from the data source

        return (user = {
          id: args.id,
          name: "Paulo",
          age: 34,
          profession: "programmer",
          //date: moment(Date.now()).format("DD/MM/YYYY"),
        });
      },
    },

    //entry
    entry: {
      type: EntryType,
      args: {
        id: {
          type: GraphQLInt,
        },
      },
      resolve(parent, args) {
        //get and return data from the data source

        return (entry = {
          // id: args.id,
          title: "first",
          description: "lalal",
          date: Date.now(),

          //date: moment(Date.now()).format("DD/MM/YYYY"),
        });
      },
    },
  },
});

//Mutations
const Mutation = new GraphQLObjectType({
  name: "CreateUser",
  fields: {
    CreateUser: {
      type: UserType,
      args: {
        name: { type: new GraphQLNonNull(GraphQLString) },
        age: { type: new GraphQLNonNull(GraphQLInt) },
        profession: { type: GraphQLString },
      },

      resolve(parent, args) {
        let user = new User({
          name: args.name,
          age: args.age,
          profession: args.profession,
        });
        //save to our db
        return user.save();
      },
    },

    //Update User
    UpdateUser: {
      type: UserType,
      args: {
        id: { type: new GraphQLNonNull(GraphQLString) },
        name: { type: new GraphQLNonNull(GraphQLString) },
        age: { type: GraphQLInt },
        profession: { type: GraphQLString },
      },
      resolve(parent, args) {
        return (updatedUser = User.findByIdAndUpdate(
          args.id,
          {
            $set: {
              name: args.name,
              age: args.age,
              profession: args.profession,
            },
          },
          { new: true } //send back the updated objectType
        ));
      },
    },

    //Remove User
    RemoveUser: {
      type: UserType,
      args: {
        id: { type: new GraphQLNonNull(GraphQLString) },
      },
      resolve(parent, args) {
        let removedUser = User.findByIdAndRemove(args.id).exec();

        if (!removedUser) {
          throw new "Error"();
        }

        return removedUser;
      },
    },
  }, //End of the fields
});
module.exports = new GraphQLSchema({
  query: RootQuery,
  mutation: Mutation,
});
