import 'package:house_party/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

//URL das requisições
final Uri urlBase = Uri(
  scheme: 'http',
  host: '192.168.0.102', // Altere esta String com o IP da máquina onde a API está sendo executada
  port: 8680
);

final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
