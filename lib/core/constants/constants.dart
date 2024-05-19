const appwriteEndPoint = 'https://cloud.appwrite.io/v1';
const appwriteProjectId = '65fe40f2dcd3c577052a';

abstract class CollectionNames {
  static String get databaseId => 'doc_app';
  static String get delta => 'delta';
  static String get deltaDocumentsPath => 'collections.$delta.documents';
  static String get pages => 'pages';
  static String get pagesDocumentPath => 'collections.$pages.documents';
}