const db = require('../config/db');

// Ambil semua kosakata
async function getAllKosakata() {
  const [rows] = await db.query('SELECT * FROM tb_kosakata');
  return rows;
}

// Tambah kosakata baru
async function createKosakata({ kata, arti, id_kategori, ejaan, gambar }) {
  const [result] = await db.query(
    'INSERT INTO tb_kosakata (kata, arti, id_kategori, ejaan, gambar) VALUES (?, ?, ?, ?, ?)',
    [kata, arti, id_kategori, ejaan, gambar]
  );
  return {
    id_kosakata: result.insertId,
    kata,
    arti,
    id_kategori,
    ejaan,
    gambar,
  };
}

// Update kosakata berdasarkan ID
async function updateKosakataById(id_kosakata, { kata, arti, id_kategori, ejaan, gambar }) {
  await db.query(
    `UPDATE tb_kosakata 
     SET kata = ?, arti = ?, id_kategori = ?, ejaan = ?, gambar = ? 
     WHERE id_kosakata = ?`,
    [kata, arti, id_kategori, ejaan, gambar, id_kosakata]
  );
}

// Hapus kosakata berdasarkan ID
async function deleteKosakataById(id_kosakata) {
  await db.query('DELETE FROM tb_kosakata WHERE id_kosakata = ?', [id_kosakata]);
}

// Ambil kosakata berdasarkan ID kategori
async function getKosakataByKategori(id_kategori) {
  const [rows] = await db.query(
    'SELECT * FROM tb_kosakata WHERE id_kategori = ?',
    [id_kategori]
  );
  return rows;
}

// Ambil kosakata berdasarkan ID (opsional)
async function findKosakataById(id_kosakata) {
  const [rows] = await db.query(
    'SELECT * FROM tb_kosakata WHERE id_kosakata = ?',
    [id_kosakata]
  );
  return rows[0];
}

module.exports = {
  getAllKosakata,
  createKosakata,
  updateKosakataById,
  deleteKosakataById,
  getKosakataByKategori,
  findKosakataById,
};
