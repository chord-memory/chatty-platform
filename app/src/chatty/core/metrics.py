"""
Prometheus metrics definitions for Socket.IO observability.
"""
from prometheus_client import Counter, Gauge

socketio_connections_total = Counter(
    "socketio_connections_total",
    "Total number of Socket.IO client connections",
)

socketio_disconnections_total = Counter(
    "socketio_disconnections_total",
    "Total number of Socket.IO client disconnections",
)

socketio_room_joins_total = Counter(
    "socketio_room_joins_total",
    "Total number of Socket.IO room joins",
    ["room"],
)

socketio_room_leaves_total = Counter(
    "socketio_room_leaves_total",
    "Total number of Socket.IO room leaves",
    ["room"],
)

socketio_messages_total = Counter(
    "socketio_messages_total",
    "Total number of messages emitted via Socket.IO",
    ["room"],
)

socketio_errors_total = Counter(
    "socketio_errors_total",
    "Total number of Socket.IO errors",
)

socketio_active_connections = Gauge(
    "socketio_active_connections",
    "Current number of active Socket.IO connections",
)

socketio_room_members = Gauge(
    "socketio_room_members",
    "Current number of members in a Socket.IO room",
    ["room"],
)
