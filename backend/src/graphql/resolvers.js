const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db');

// Import user model
const {
  findUserByEmail,
  createUser,
  getAllUsers,
  findUserById,
  updateUserById,
  deleteUserById,
} = require('../models/userModel');

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

     getCurrentUser: async (_, __, { user }) => {
  if (!user || !user.id) {
    console.error("Token tidak valid atau user tidak tersedia di context");
    throw new Error("Unauthorized");
  }

  const currentUser = await findUserById(user.id);
  if (!currentUser) {
    console.error(`User dengan ID ${user.id} tidak ditemukan di database`);
    throw new Error("User not found");
  }

  return currentUser;
},

    getAllUsers: async () => {
      try {
        return await getAllUsers();
      } catch (error) {
        throw new Error("Gagal mengambil data user: " + error.message);
      }
    },

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
    register: async (_, { username, email, password }) => {
      const existingUser = await findUserByEmail(email);
      if (existingUser) throw new Error("Email sudah terdaftar");

      const hashed = await bcrypt.hash(password, 10);
      await createUser({ username, email, password: hashed });
      return "User registered";
    },

    login: async (_, { email, password }) => {
  const user = await findUserByEmail(email);
  if (!user) throw new Error("Email tidak ditemukan");

  const passwordMatch = await bcrypt.compare(password, user.password);
  if (!passwordMatch) throw new Error("Password salah");

  // Inilah bagian token dibuat dan dicetak ke console
  const token = jwt.sign(
    { id: user.id, email: user.email },
    JWT_SECRET,
    { expiresIn: '1d' }
  );
  console.log("Token berhasil dibuat:", token);

  return {
    token,
    user: {
      id: user.id,
      username: user.username,
      email: user.email
    }
  };
},

    updateUser: async (_, { username, email }, { user }) => {
      if (!user || !user.id) throw new Error("Unauthorized");

      const update = {};
      if (username) update.username = username;
      if (email) update.email = email;

      const updatedUser = await updateUserById(user.id, update);
      if (!updatedUser) throw new Error("Gagal memperbarui user");
      return updatedUser;
    },

    changePassword: async (_, { currentPassword, newPassword }, { user }) => {
      if (!user || !user.id) throw new Error("Unauthorized");

      const existingUser = await findUserById(user.id);
      if (!existingUser) throw new Error("User tidak ditemukan");

      const isMatch = await bcrypt.compare(currentPassword, existingUser.password);
      if (!isMatch) throw new Error("Password saat ini salah");

      const hashedPassword = await bcrypt.hash(newPassword, 10);
      await db.query('UPDATE tb_user SET password = ? WHERE id = ?', [hashedPassword, user.id]);

      return true;
    },

    deleteUser: async (_, __, { user }) => {
      if (!user || !user.id) throw new Error("Unauthorized");
      await deleteUserById(user.id);
      return true;
    },

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

      
    }
  }
};

module.exports = resolvers;
