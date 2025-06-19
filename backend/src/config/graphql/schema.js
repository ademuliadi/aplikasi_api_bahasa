const { gql } = require('apollo-server-express');

const typeDefs = gql`
  type User {
    id: ID!
    username: String!
    email: String!
  }

  type LoginResponse {
    token: String!
    user: User!
  }

type Kosakata {
    id_kosakata: ID!
    kata: String!
    arti: String!
    id_kategori: ID!
    ejaan: String!
    gambar: String!
  }

  type Kategori {
    id_kategori: ID!
    kategori: String!
  }

type Query {
  getAllKosakata: [Kosakata!]!
    getAllKategori: [Kategori!]!
    getKosakataByKategori(kategori: String!): [Kosakata!]!
  }

  type Mutation {
     addKosakata(
      kata: String!
      arti: String!
      id_kategori: String!
      ejaan: String!
      gambar: String!
    ): Kosakata!

    updateKosakata(
      id_kosakata: ID!
      kata: String!
      arti: String!
      id_kategori: String!
      ejaan: String!
      gambar: String!
    ): Kosakata!

    deleteKosakata(id_kosakata: ID!): Boolean!
  }
`;

module.exports = typeDefs;
  