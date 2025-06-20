const db = require('../config/db');

/**
 * Cari user berdasarkan email
 * @param {string} email
 * @returns {Promise<Object|null>}
 */
async function findUserByEmail(email) {
  const [rows] = await db.query(
    'SELECT id, username, email, password FROM tb_user WHERE email = ?',
    [email]
  );
  return rows[0] || null;
}

/**
 * Cari user berdasarkan ID
 * @param {number} id
 * @returns {Promise<Object|null>}
 */
async function findUserById(id) {
  const [rows] = await db.query(
    'SELECT id, username, email FROM tb_user WHERE id = ?',
    [id]
  );
  return rows[0] || null;
}

/**
 * Buat user baru
 * @param {{ username: string, email: string, password: string }} data
 */
async function createUser({ username, email, password }) {
  await db.query(
    'INSERT INTO tb_user (username, email, password) VALUES (?, ?, ?)',
    [username, email, password]
  );
}

/**
 * Update user berdasarkan ID
 * @param {number} id
 * @param {{ username?: string, email?: string }} updateData
 * @returns {Promise<Object|null>}
 */
async function updateUserById(id, updateData) {
  const fields = [];
  const values = [];

  if (updateData.username) {
    fields.push('username = ?');
    values.push(updateData.username);
  }

  if (updateData.email) {
    fields.push('email = ?');
    values.push(updateData.email);
  }

  if (fields.length === 0) return await findUserById(id); // Tidak ada perubahan

  values.push(id); // Untuk WHERE id = ?
  await db.query(`UPDATE tb_user SET ${fields.join(', ')} WHERE id = ?`, values);

  return await findUserById(id);
}

/**
 * Hapus user berdasarkan ID
 * @param {number} id
 */
async function deleteUserById(id) {
  await db.query('DELETE FROM tb_user WHERE id = ?', [id]);
}

/**
 * Ambil semua user
 * @returns {Promise<Array>}
 */
async function getAllUsers() {
  const [rows] = await db.query('SELECT id, username, email FROM tb_user');
  return rows;
}

module.exports = {
  findUserByEmail,
  findUserById,
  createUser,
  updateUserById,
  deleteUserById,
  getAllUsers
};
