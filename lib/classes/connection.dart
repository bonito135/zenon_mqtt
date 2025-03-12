import 'dart:io';

import 'package:flutter/cupertino.dart';
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
      print('EXAMPLE::Ping response client callback invoked');
      pongCount++;
      print(
        'EXAMPLE::Latency of this ping/pong cycle is ${client.lastCycleLatency} milliseconds',
      );
    };

    client.pingCallback = () {
      print('EXAMPLE::Ping sent client callback invoked');
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

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('EXAMPLE:Client connected');
      isConnected.value = true;
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
        'EXAMPLE::ERROR Client connection failed - disconnecting, status is ${client.connectionStatus}',
      );

      client.disconnect();
    }

    try {
      print('EXAMPLE::Subscribing to the $topic topic');
      client.subscribe(topic, MqttQos.exactlyOnce);
    } catch (e) {
      print('EXAMPLE::Error subscribing to the $topic topic');
      print(e);
    }
  }

  Future<void> connect() async {
    try {
      print('EXAMPLE::Client connecting....');
      await client.connect();

      client.updates!.listen((
        List<MqttReceivedMessage<MqttMessage?>>? c,
      ) async {
        try {
          final recMess = c![0].payload as MqttPublishMessage;
          final value = MqttPublishPayload.bytesToStringAsString(
            recMess.payload.message,
          );

          if (storage != null) {
            await storage!.writeStorage(value);
          }

          await onMessage(value);
        } catch (e) {
          print('EXAMPLE::exception - $e');
          // client.disconnect();
        }

        /// The above may seem a little convoluted for users only interested in the
        /// payload, some users however may be interested in the received publish message,
        /// lets not constrain ourselves yet until the package has been in the wild
        /// for a while.
        /// The payload is a byte buffer, this will be specific to the topic
        // print(
        //   'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->',
        // );
      });
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      client.disconnect();
    } catch (e) {
      print('EXAMPLE::exception - $e');
      client.disconnect();
    }
  }

  void _onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  void onConnected() {
    isConnected.value = true;
    print(
      'EXAMPLE::OnConnected client callback - Client connection was successful',
    );
  }

  void onDisconnected() {
    isConnected.value = false;
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    } else {
      print(
        'EXAMPLE::OnDisconnected callback is unsolicited or none, this is incorrect - exiting',
      );
    }
  }
}
