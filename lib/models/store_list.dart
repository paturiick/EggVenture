import 'package:eggventure/routes/routes.dart';

class StoreList {
  final String name;
  final String routeName;

  StoreList({required this.name, required this.routeName});
}

final List<StoreList> store = [
  StoreList(name: 'White Feathers', routeName: AppRoutes.WHITEFEATHERS),
  StoreList(name: 'Pabilona Duck Farm', routeName: AppRoutes.PABILONA),
  StoreList(name: 'Vista', routeName: AppRoutes.VISTA),
  StoreList(name: 'Pabilona', routeName: AppRoutes.PABILONA),
  StoreList(name: 'Sundo', routeName: AppRoutes.SUNDO),
  StoreList(name: 'Daily Fresh', routeName: AppRoutes.DAILYFRESH),
  StoreList(name: 'Pelonio', routeName: AppRoutes.PELONIO),
  ];
