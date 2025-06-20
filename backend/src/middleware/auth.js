const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET;

const getUser = (req) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    console.warn("Header Authorization tidak valid");
    return null;
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    // Pastikan decoded memiliki `id`
    return decoded;
  } catch (error) {
    console.error("Token JWT tidak valid:", error.message);
    return null;
  }
};

module.exports = getUser;