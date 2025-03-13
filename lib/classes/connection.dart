import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:zenon_mqtt/classes/storage.dart';

class MQTTConnection with ChangeNotifier {
  final MqttServerClient client;
  final String topic;
  final MqttConnectMessage connMess;
  final dynamic Function(String) onMessage;
  final Storage? storage;

  MQTTConnection(
    this.client,
    this.topic,
    this.connMess,
    this.onMessage,
    this.storage,
  );

  final ValueNotifier<bool> isConnected = ValueNotifier(false);

  var pongCount = 0; // Pong counter
  var pingCount = 0; // Ping counter

  Future<void> init() async {
    try {
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

      await connect();

      client.pongCallback = () {
        // print('EXAMPLE::Ping response client callback invoked');
        pongCount++;
        // print(
        //   'EXAMPLE::Latency of this ping/pong cycle is ${client.lastCycleLatency} milliseconds',
        // );
      };

      client.pingCallback = () {
        // print('EXAMPLE::Ping sent client callback invoked');
        pingCount++;
      };

      /// Add the unsolicited disconnection callback
      client.onDisconnected = onDisconnected;

      /// Add the successful connection callback
      client.onConnected = onConnected;

      /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
      /// You can add these before connection or change them dynamically after connection if
      /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
      /// can fail either because you have tried to subscribe to an invalid topic or the broker
      /// rejects the subscribe request.
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

      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        isConnected.value = true;
      } else {
        client.disconnect();
      }

      try {
        // print('EXAMPLE::Subscribing to the $topic topic');
        client.subscribe(topic, MqttQos.exactlyOnce);
      } catch (e) {
        if (kDebugMode) {
          print('EXAMPLE::Error subscribing to the $topic topic');
          print(e);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('EXAMPLE::exception - $e');
      }
    }
  }

  Future<void> connect() async {
    try {
      // print('EXAMPLE::Client connecting....');
      await client.connect();

      client.updates!.listen((
        List<MqttReceivedMessage<MqttMessage?>>? c,
      ) async {
        try {
          final recMess = c![0].payload as MqttPublishMessage;
          final value = MqttPublishPayload.bytesToStringAsString(
            recMess.payload.message,
          );

          /// The above may seem a little convoluted for users only interested in the
          /// payload, some users however may be interested in the received publish message,
          /// lets not constrain ourselves yet until the package has been in the wild
          /// for a while.
          /// The payload is a byte buffer, this will be specific to the topic
          if (kDebugMode) {
            print(
              'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $value -->',
            );
          }

          if (storage != null) {
            await storage!.writeStorage(value);
          }

          await onMessage(value);
        } catch (e) {
          if (kDebugMode) {
            print('EXAMPLE::exception - $e');
          }
        }
      });
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      if (kDebugMode) {
        print('EXAMPLE::client exception - $e');
      }
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      if (kDebugMode) {
        print('EXAMPLE::socket exception - $e');
      }
      client.disconnect();
    } catch (e) {
      if (kDebugMode) {
        print('EXAMPLE::exception - $e');
      }
      client.disconnect();
    }
  }

  void _onSubscribed(String topic) {
    if (kDebugMode) {
      print('EXAMPLE::Subscription confirmed for topic $topic');
    }
  }

  /// The pre auto re connect callback
  void onAutoReconnect() {
    if (kDebugMode) {
      print(
        'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start',
      );
    }
  }

  /// The post auto re connect callback
  void onAutoReconnected() {
    isConnected.value = true;
    if (kDebugMode) {
      print(
        'EXAMPLE::onAutoReconnected client callback - Client auto reconnection sequence has completed',
      );
    }
  }

  void onConnected() {
    isConnected.value = true;
    if (kDebugMode) {
      print(
        'EXAMPLE::OnConnected client callback - Client connection was successful',
      );
    }
  }

  void onDisconnected() {
    isConnected.value = false;
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
}
