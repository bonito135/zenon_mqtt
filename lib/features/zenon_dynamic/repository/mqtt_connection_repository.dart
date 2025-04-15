import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:zenon_mqtt/core/utils/debouncer_util.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/convert.dart';
import 'package:zenon_mqtt/features/zenon_dynamic/model/zenon_value_update.dart';

class MqttConnectionRepository<T> {
  MqttConnectionRepository(
    this.client,
    this.topic,
    this.connMess,
    this.autoReconnect,
  );

  final MqttServerClient client;
  final String topic;
  final MqttConnectMessage connMess;
  final bool autoReconnect;
  final ValueNotifier<MqttConnectionState> stateNotifier =
      ValueNotifier<MqttConnectionState>(MqttConnectionState.disconnected);
  final ValueNotifier<T?> messageNotifier = ValueNotifier<T?>(null);

  final _connectionDebouncer = Debouncer();
  final _messageDebouncer = Debouncer();

  var pongCount = 0; // Pong counter
  var pingCount = 0; // Ping counter

  void init() {
    /// Set logging on if needed, defaults to off
    client.logging(on: false);

    /// Set the correct MQTT protocol
    client.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 2;

    /// The connection timeout period can be set, the default is 5 seconds.
    /// if [client.socketTimeout] is set then this will take precedence and this setting will be
    /// disabled.
    client.connectTimeoutPeriod = 5000; // milliseconds

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    client.connectionMessage = connMess;

    // client.pingCallback = onPingCallback;

    client.pongCallback = onPongCallback;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    client.onSubscribed = _onSubscribed;

    /// Set the ping response disconnect period, if a ping response is not received from the broker in this period
    /// the client will disconnect itself.
    /// Note you should somehow get your broker to stop sending ping responses without forcing a disconnect at the
    /// network level to run this example. On way to do this if you are using a wired network connection is to pull
    /// the wire, on some platforms no network events will be generated until the wire is re inserted.
    client.disconnectOnNoResponsePeriod = 2;

    /// Set auto reconnect
    client.autoReconnect = autoReconnect;

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
      _connectionDebouncer.call(() async {
        try {
          init();

          stateNotifier.value = MqttConnectionState.connecting;

          await client.connect();

          client.subscribe(topic, MqttQos.exactlyOnce);
          if (kDebugMode) {
            print('EXAMPLE::Subscribing to the $topic topic');
          }
        } catch (e) {
          if (kDebugMode) {
            print('EXAMPLE::Error subscribing to the $topic topic');
            log("$e");
          }
          stateNotifier.value = MqttConnectionState.disconnecting;
          client.disconnect();
        }
      });
    } else {
      if (kDebugMode) {
        log("Can not connect to topic: $topic / Not disconnected");
      }
    }
  }

  void onConnected() {
    stateNotifier.value = MqttConnectionState.connected;
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
    // if (kDebugMode) {
    //   print('EXAMPLE::Subscription confirmed for topic $topic');
    // }
  }

  void listen() async {
    if (stateNotifier.value == MqttConnectionState.connected) {
      client.updates!.listen(
        (List<MqttReceivedMessage<MqttMessage?>>? c) async {
          final recMess = c![0].payload as MqttPublishMessage;
          final value = MqttPublishPayload.bytesToStringAsString(
            recMess.payload.message,
          );

          _messageDebouncer.call(() {
            messageNotifier.value = handleValueTypes(value);
          });
        },
        onError:
            (e) => {
              if (kDebugMode) {log('MESSAGE_LISTENER::exception - $e')},
            },
      );
    } else {
      throw Exception("Can not listen to topic: $topic / Not connected");
    }
  }

  void onDisconnected() {
    stateNotifier.value = MqttConnectionState.disconnected;
  }

  void onPingCallback() {}

  void onPongCallback() {}

  void dispose() {
    client.disconnect();
    _connectionDebouncer.dispose();
    _messageDebouncer.dispose();
  }

  T? handleValueTypes(String value) {
    if (T.toString() == "ZenonValueUpdate") {
      return ZenonValueUpdate.fromJson(
            jsonDecode(value) as Map<String, dynamic>,
          )
          as T;
    }

    if (T.toString() == "ConfigStructure") {
      return ConfigStructure.fromJson(jsonDecode(value) as Map<String, dynamic>)
          as T;
    }

    return null;
  }
}
