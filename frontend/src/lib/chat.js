const WEBSOCKET_URL = import.meta.env.VITE_WEBSOCKET_URL || 'wss://wara1-backend.onrender.com/cable';

export function connectWebSocket(room, nickname, onMessage) {
    const socket = new WebSocket(WEBSOCKET_URL);

    socket.onopen = () => {
        console.log(`Connected to ${WEBSOCKET_URL} (room: ${room})`);
        socket.send(JSON.stringify({
            command: 'subscribe',
            identifier: JSON.stringify({ channel: 'LobbyChannel', room, nickname }),
        }));
    };

    socket.onmessage = (event) => {
        const response = JSON.parse(event.data);
        if (response.type === 'ping' || !response.message) return;

        if (response.message) {
            onMessage(response.message); // メッセージを受信したらコールバック実行
        }
    };

    socket.onerror = (error) => console.error('WebSocket Error:', error);
    socket.onclose = () => console.log('WebSocket closed');

    return socket;
}
