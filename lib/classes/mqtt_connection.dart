import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttConnection {
  MqttConnection(this.client, this.topic, this.connMess);

  final MqttServerClient client;
  final String topic;
  final MqttConnectMessage connMess;
  final ValueNotifier<MqttConnectionState> stateNotifier =
      ValueNotifier<MqttConnectionState>(MqttConnectionState.disconnected);
  final ValueNotifier<String?> messageNotifier = ValueNotifier<String?>(null);

  var pongCount = 0; // Pong counter
  var pingCount = 0; // Ping counter

  void init() {
    /// Set logging on if needed, defaults to off
    client.logging(on: false);

    /// Set the correct MQTT protocol
    client.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 2000;

    /// The connection timeout period can be set, the default is 5 seconds.
    /// if [client.socketTimeout] is set then this will take precedence and this setting will be
    /// disabled.
    client.connectTimeoutPeriod = 5000; // milliseconds

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    client.connectionMessage = connMess;

    client.pongCallback = onPongCallback;

    client.pingCallback = onPingCallback;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    client.onSubscribed = _onSubscribed;

    /// Set auto reconnect
    client.autoReconnect = true;

    /// If you do not want active confirmed subscriptions to be automatically re subscribed
    /// by the auto connect sequence do the following, otherwise leave this defaulted.
    // client.resubscribeOnAutoReconnect = false;

    /// Add an auto reconnect callback.
    /// This is the 'pre' auto re connect callback, called before the sequence starts.
    client.onAutoReconnect = onAutoReconnect;

    /// Add an auto reconnect callback.
    /// This is the 'post' auto re connect callback, called after the sequence
    /// has completed. Note that re subscriptions may be occurring when this callback
    /// is invoked. See [resubscribeOnAutoReconnect] above.
    client.onAutoReconnected = onAutoReconnected;
  }

  Future<void> connect() async {
    if (stateNotifier.value == MqttConnectionState.disconnected) {
      try {
        init();

        stateNotifier.value = MqttConnectionState.connecting;

        await client.connect();

        client.subscribe(topic, MqttQos.exactlyOnce);
        if (kDebugMode) {
          log('EXAMPLE::Subscribing to the $topic topic');
        }
      } catch (e) {
        if (kDebugMode) {
          log('EXAMPLE::Error subscribing to the $topic topic');
          log("$e");
        }
        stateNotifier.value = MqttConnectionState.disconnecting;
        client.disconnect();
      }
    } else {
      log("Can not connect to topic: $topic / Not disconnected");
    }
  }

  void onConnected() {
    stateNotifier.value = MqttConnectionState.connected;

    if (kDebugMode) {
      print(
        'EXAMPLE::OnConnected client callback - Client connection was successful',
      );
    }
  }

  void onAutoReconnect() {
    stateNotifier.value = MqttConnectionState.connecting;

    if (kDebugMode) {
      print(
        'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start',
      );
    }
  }

  void onAutoReconnected() {
    stateNotifier.value = MqttConnectionState.connected;

    if (kDebugMode) {
      print(
        'EXAMPLE::onAutoReconnected client callback - Client auto reconnection sequence has completed',
      );
    }
  }

  void _onSubscribed(String topic) {
    if (kDebugMode) {
      print('EXAMPLE::Subscription confirmed for topic $topic');
    }
  }

  void listen() async {
    if (stateNotifier.value == MqttConnectionState.connected) {
      client.updates!.listen(
        (List<MqttReceivedMessage<MqttMessage?>>? c) async {
          final recMess = c![0].payload as MqttPublishMessage;
          final value = MqttPublishPayload.bytesToStringAsString(
            recMess.payload.message,
          );

          if (kDebugMode) {
            print(
              'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $value -->',
            );
          }

          messageNotifier.value = value;
        },
        onError:
            (e) => {
              if (kDebugMode) {log('MESSAGE_LISTENER::exception - $e')},
            },
      );
    } else {
      log("Can not listen to topic: $topic / Not connected");
    }
  }

  void onDisconnected() {
    stateNotifier.value = MqttConnectionState.disconnected;

    if (kDebugMode) {
      print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    }
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      if (kDebugMode) {
        print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
      }
    } else {
      if (kDebugMode) {
        print(
          'EXAMPLE::OnDisconnected callback is unsolicited or none, this is incorrect - exiting',
        );
      }
    }
  }

  void onPingCallback() {
    if (kDebugMode) {
      print('EXAMPLE::Ping sent client callback invoked');
    }
    // pingCount++;
  }

  void onPongCallback() {
    if (kDebugMode) {
      print('EXAMPLE::Ping response client callback invoked');
    }
    // pongCount++;
    if (kDebugMode) {
      print(
        'EXAMPLE::Latency of this ping/pong cycle is ${client.lastCycleLatency} milliseconds',
      );
    }
  }
}
