const WebSocket = require('ws');

function setupWebSocket() {
  const wss = new WebSocket.Server({ port: 4001 });

  wss.on('connection', (ws) => {
    console.log("💬 Client WebSocket terhubung di port 4001!");

    ws.send(JSON.stringify({ message: "Halo dari server WebSocket!" }));

    ws.on('message', (msg) => {
      console.log("📩 Pesan dari client:", msg.toString());

      // Kirim pesan ke semua client
      wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
          client.send(msg); // kirim ulang pesan yang diterima
        }
      });
    });

    ws.on('close', () => {
      console.log("🔌 Client WebSocket terputus.");
    });
  });

  wss.on('error', (err) => {
    console.error("❌ WebSocket error:", err.message);
  });
}

module.exports = setupWebSocket;
