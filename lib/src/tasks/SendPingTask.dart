import 'dart:convert';

import 'package:askless/src/middleware/data/connection/PingPong.dart';
import 'package:askless/src/middleware/data/response/ConfigureConnectionResponseCli.dart';
import 'package:askless/src/tasks/TimedTask.dart';

import '../index.dart';

class SendPingTask extends TimedTask{

  SendPingTask() : super('SendPingTask', new ConnectionConfiguration().intervalInSecondsClientPing);

  @override
  void run() {
    List<ListeningTo> listeningTo = [];
    Internal.instance.middleware.listeningTo.forEach((listen) {
      listeningTo.add(new ListeningTo(clientRequestId:listen.clientRequestId, listenId: listen.listenId, route: listen.route, query: listen.query));
    });
    Internal.instance.middleware?.channel?.sink?.add(jsonEncode(new PingPong(listeningToRoutes: listeningTo).toMap())); //TODO: remover do lado web o que foi adicionado aqui?
  }

}
