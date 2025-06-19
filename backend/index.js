console.log("🚀 Memulai index.js...");

// Load environment variables
require('dotenv').config();

// Import dependencies
const express = require('express');
const http = require('http');
const { ApolloServer } = require('apollo-server-express');
const typeDefs = require('./graphql/schema');
const resolvers = require('./graphql/resolvers');
const db = require('./config/db');
const getUser = require('./middleware/auth');
const setupWebSocket = require('./websocket/socket');

// Konstanta port
const PORT = process.env.PORT || 4000;

// Cek JWT_SECRET
if (!process.env.JWT_SECRET) {
  console.error("❌ JWT_SECRET belum diset di .env");
  process.exit(1);
}

// Fungsi utama untuk menjalankan server
async function startServer() {
  console.log("⚙️ Menjalankan startServer...");

  try {
    // Tes koneksi database
    await db.query('SELECT 1');
    console.log("✅ Koneksi database berhasil!");

    const app = express();
    const httpServer = http.createServer(app);

    // Inisialisasi Apollo Server
    const server = new ApolloServer({
      typeDefs,
      resolvers,
      context: ({ req }) => {
        const user = getUser(req);
        console.log("🧠 Context user:", user);
        return { user };
      },
    });

    await server.start();
    server.applyMiddleware({ app });

    // Jalankan HTTP server
    httpServer.listen(PORT, () => {
      console.log(`🚀 Server aktif di: http://localhost:${PORT}${server.graphqlPath}`);
    });

    // Jalankan WebSocket server (jika diperlukan)
    setupWebSocket();

  } catch (err) {
    console.error("❌ Gagal menjalankan server:", err.message);
    process.exit(1);
  }
}

startServer();
