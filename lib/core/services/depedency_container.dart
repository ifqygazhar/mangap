import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mangap/core/services/network_info.dart';
import 'package:mangap/fetures/home/data/datasources/home_remote_datasource.dart';
import 'package:mangap/fetures/home/data/repositories/home_repository_impl.dart';
import 'package:mangap/fetures/home/domain/repositories/home_repository.dart';

import 'package:mangap/fetures/home/domain/usecases/get_latest_komik.dart';
import 'package:mangap/fetures/home/domain/usecases/get_popular_komik.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';

part 'depedency_container_main.dart';
