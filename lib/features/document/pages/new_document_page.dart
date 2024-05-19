import 'package:doc_edit_flutter/core/dependency/dependency.dart';
import 'package:doc_edit_flutter/core/exception/repo_exception.dart';
import 'package:doc_edit_flutter/core/navigation/routes.dart';
import 'package:doc_edit_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

class NewDocumentPage extends ConsumerStatefulWidget {
  const NewDocumentPage({
    super.key,
  });

  @override
  ConsumerState<NewDocumentPage> createState() => _NewDocumentPageState();
}

class _NewDocumentPageState extends ConsumerState<NewDocumentPage> {
  final _uuid = const Uuid();

  bool showError = false;
  Future<void> _createNewPage(String documentId) async {

    try {
      await ref.read(Repository.database).createNewPage(
            documentId: documentId,
            owner: ref.read(AppState.auth).user!.$id,
          );
      Routemaster.of(context).push('${AppRoutes.document}/$documentId');
    } on RepositoryException catch (_) {
      setState(() {
        showError = true;
      });
    }
  }
  bool runFirst = true;
  @override
  void didChangeDependencies() async {
    if(runFirst){
      final documentId = _uuid.v4();
      await _createNewPage(documentId);
      runFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (showError) {
      return const Center(
        child: Text('There is error',style: TextStyle(color: Colors.black),),
      );
    } else {
      Routemaster.of(context).push('${AppRoutes.document}/123');
      return const SizedBox();
    }
  }
}
