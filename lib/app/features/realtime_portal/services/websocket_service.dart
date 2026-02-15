import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';

/// WebSocket service for real-time communication
class WebSocketService {
  late IO.Socket socket;
  bool _isConnected = false;
  String? _userId;
  String? _userType;

  // Event callbacks
  Function(LiveLocation)? onLocationUpdate;
  Function(GeofenceEvent)? onGeofenceEvent;
  Function(AppointmentStatus)? onStatusUpdate;
  Function(SecureMessage)? onNewMessage;
  Function(TypingIndicator)? onTypingIndicator;
  Function(String)? onMessageRead;
  Function(EmergencyAlert)? onEmergencyAlert;
  Function(bool)? onConnectionChange;

  /// Initialize WebSocket connection
  void connect({
    required String serverUrl,
    required String userId,
    required String userType,
    required String token,
  }) {
    _userId = userId;
    _userType = userType;

    socket = IO.io(
      serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    // Connection events
    socket.onConnect((_) {
      debugPrint('WebSocket connected');
      _isConnected = true;
      onConnectionChange?.call(true);

      // Authenticate
      socket.emit('authenticate', {
        'userId': userId,
        'userType': userType,
        'token': token,
      });

      // Join user room for direct messages
      socket.emit('join-user-room');
    });

    socket.onDisconnect((_) {
      debugPrint('WebSocket disconnected');
      _isConnected = false;
      onConnectionChange?.call(false);
    });

    socket.onConnectError((error) {
      debugPrint('WebSocket connection error: $error');
      _isConnected = false;
      onConnectionChange?.call(false);
    });

    // Authentication response
    socket.on('authenticated', (data) {
      debugPrint('WebSocket authenticated: $data');
    });

    socket.on('authentication-error', (data) {
      debugPrint('WebSocket authentication error: $data');
    });

    // Real-time tracking events
    socket.on('worker-location', (data) {
      try {
        final location = LiveLocation.fromJson(data);
        onLocationUpdate?.call(location);
      } catch (e) {
        debugPrint('Error parsing location update: $e');
      }
    });

    socket.on('geofence-event', (data) {
      try {
        final event = GeofenceEvent.fromJson(data);
        onGeofenceEvent?.call(event);
      } catch (e) {
        debugPrint('Error parsing geofence event: $e');
      }
    });

    socket.on('appointment-status', (data) {
      try {
        final status = AppointmentStatus.fromJson(data);
        onStatusUpdate?.call(status);
      } catch (e) {
        debugPrint('Error parsing status update: $e');
      }
    });

    // Messaging events
    socket.on('new-message', (data) {
      try {
        final message = SecureMessage.fromJson(data);
        onNewMessage?.call(message);
      } catch (e) {
        debugPrint('Error parsing new message: $e');
      }
    });

    socket.on('message-sent', (data) {
      debugPrint('Message sent confirmation: $data');
    });

    socket.on('message-error', (data) {
      debugPrint('Message error: $data');
    });

    socket.on('user-typing', (data) {
      try {
        final indicator = TypingIndicator(
          userId: data['userId'],
          userName: data['userName'] ?? 'User',
          conversationId: data['conversationId'],
          isTyping: true,
        );
        onTypingIndicator?.call(indicator);
      } catch (e) {
        debugPrint('Error parsing typing indicator: $e');
      }
    });

    socket.on('user-stopped-typing', (data) {
      try {
        final indicator = TypingIndicator(
          userId: data['userId'],
          userName: data['userName'] ?? 'User',
          conversationId: data['conversationId'],
          isTyping: false,
        );
        onTypingIndicator?.call(indicator);
      } catch (e) {
        debugPrint('Error parsing typing indicator: $e');
      }
    });

    socket.on('message-read-receipt', (data) {
      try {
        final messageId = data['messageId'] as String;
        onMessageRead?.call(messageId);
      } catch (e) {
        debugPrint('Error parsing read receipt: $e');
      }
    });

    // Emergency events
    socket.on('emergency-alert', (data) {
      try {
        final alert = EmergencyAlert.fromJson(data);
        onEmergencyAlert?.call(alert);
      } catch (e) {
        debugPrint('Error parsing emergency alert: $e');
      }
    });

    // Heartbeat
    socket.on('heartbeat', (data) {
      // Keep connection alive
    });

    // Connect
    socket.connect();
  }

  /// Disconnect WebSocket
  void disconnect() {
    if (_isConnected) {
      socket.disconnect();
      _isConnected = false;
    }
  }

  /// Join appointment room
  void joinAppointment(String appointmentId) {
    if (_isConnected) {
      socket.emit('join-appointment', {'appointmentId': appointmentId});
    }
  }

  /// Leave appointment room
  void leaveAppointment(String appointmentId) {
    if (_isConnected) {
      socket.emit('leave-appointment', {'appointmentId': appointmentId});
    }
  }

  /// Send location update
  void sendLocationUpdate({
    required String appointmentId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) {
    if (_isConnected) {
      socket.emit('location-update', {
        'appointmentId': appointmentId,
        'latitude': latitude,
        'longitude': longitude,
        'accuracy': accuracy,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  /// Send status update
  void sendStatusUpdate({
    required String appointmentId,
    required String status,
    int? progress,
    String? notes,
  }) {
    if (_isConnected) {
      socket.emit('status-update', {
        'appointmentId': appointmentId,
        'status': status,
        'progress': progress,
        'notes': notes,
      });
    }
  }

  /// Send message
  void sendMessage({
    required String conversationId,
    required String recipientId,
    required String message,
    List<Map<String, dynamic>>? attachments,
  }) {
    if (_isConnected) {
      socket.emit('send-message', {
        'conversationId': conversationId,
        'recipientId': recipientId,
        'message': message,
        'attachments': attachments,
      });
    }
  }

  /// Send typing indicator
  void sendTypingStart({
    required String conversationId,
    required String recipientId,
  }) {
    if (_isConnected) {
      socket.emit('typing-start', {
        'conversationId': conversationId,
        'recipientId': recipientId,
      });
    }
  }

  /// Send typing stopped
  void sendTypingStop({
    required String conversationId,
    required String recipientId,
  }) {
    if (_isConnected) {
      socket.emit('typing-stop', {
        'conversationId': conversationId,
        'recipientId': recipientId,
      });
    }
  }

  /// Mark message as read
  void markMessageAsRead({
    required String messageId,
    required String conversationId,
  }) {
    if (_isConnected) {
      socket.emit('message-read', {
        'messageId': messageId,
        'conversationId': conversationId,
      });
    }
  }

  /// Send emergency SOS
  void sendEmergencySOS({
    required String appointmentId,
    required Map<String, double> location,
    String? message,
  }) {
    if (_isConnected) {
      socket.emit('emergency-sos', {
        'appointmentId': appointmentId,
        'location': location,
        'message': message,
      });
    }
  }

  /// Check if connected
  bool get isConnected => _isConnected;

  /// Get user ID
  String? get userId => _userId;

  /// Get user type
  String? get userType => _userType;

  /// Dispose
  void dispose() {
    disconnect();
  }
}
