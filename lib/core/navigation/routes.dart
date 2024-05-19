

import 'package:doc_edit_flutter/features/auth/pages/login_page/login_page.dart';
import 'package:routemaster/routemaster.dart';

import '../../features/auth/pages/register_page/register_page.dart';
import '../../features/document/pages/document_page.dart';
import '../../features/document/pages/new_document_page.dart';


const _login = '/login';
const _register = '/register';
const _document = '/document';
const _newDocument = '/newDocument';

abstract class AppRoutes{
  static String get document => _document;
  static String get newDocument => _newDocument;
  static String get register => _register;
  static String get login => _login;
}

final routesLoggedOut = RouteMap(
  onUnknownRoute: (_) => const Redirect(_login),
  routes: {
    _login : (_) => const TransitionPage(child: LoginPage(),),
    _register: (_) => const TransitionPage(child: RegisterPage(),),
  }
);
final routesLoggedIn = RouteMap(
  onUnknownRoute: (_) => const Redirect(_newDocument),
  routes: {
    _newDocument: (_) => const TransitionPage(child: NewDocumentPage(),),
    '$_document/:id' : (info){
      print('we are here');
      final docId = info.pathParameters['id'];
      if(docId == null){
        print('we are here like');
        return const Redirect(_newDocument);
      }
      return TransitionPage(child: DocumentPage(documentId: docId));
    }
  }
);