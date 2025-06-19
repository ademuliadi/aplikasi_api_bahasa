const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db');

const {
  getAllKosakata,
  createKosakata,
  getKosakataByKategori,
  updateKosakataById,
  deleteKosakataById,
  findKosakataById,
} = require('../models/kosakataModel.js');

const JWT_SECRET = process.env.JWT_SECRET;

const resolvers = {
  Query: {

    getAllKosakata: async () => {
      try {
        return await getAllKosakata();
      } catch (error) {
        throw new Error("Gagal mengambil data kosakata: " + error.message);
      }
    },
    getKosakataByKategori: async (_, { kategori }) => {
      try {
        return await getKosakataByKategori(kategori);
      } catch (error) {
        throw new Error("Gagal filter kosakata: " + error.message);
      }
    },
  },

  Mutation: {
  addKosakata: async (_, args, { user }) => {
      if (!user || !user.id) throw new Error("Unauthorized");
      const kosakataBaru = await createKosakata(args);
      return kosakataBaru;
    },

    updateKosakata: async (_, { id_kosakata, ...rest }, { user }) => {
      if (!user || !user.id) throw new Error("Unauthorized");

      const updated = await updateKosakataById(id_kosakata, rest);
      if (!updated) throw new Error("Kosakata tidak ditemukan atau gagal diupdate");

      const kosakata = await findKosakataById(id_kosakata);
      return kosakata;
    },

    deleteKosakata: async (_, { id_kosakata }, { user }) => {
      if (!user || !user.id) throw new Error("Unauthorized");

      const deleted = await deleteKosakataById(id_kosakata);
      if (!deleted) throw new Error("Gagal menghapus kosakata");
