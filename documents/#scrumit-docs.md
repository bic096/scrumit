# scrumit
appwrite document json object
---
````  json 
{
    "$id": "5e5ea5c16897e",
    "$collectionId": "5e5ea5c15117e",
    "$databaseId": "5e5ea5c15117e",
    "$createdAt": "2020-10-15T06:38:00.000+00:00",
    "$updatedAt": "2020-10-15T06:38:00.000+00:00",
    "$permissions": [
        "read(\"any\")"
    ]
} 
````
---
>## **create a document**
>
>the code snippts for create a document
```dart
import 'package:appwrite/appwrite.dart';

void main() { // Init SDK
  Client client = Client();
  Databases databases = Databases(client);

  client
    .setEndpoint('https://[HOSTNAME_OR_IP]/v1') // Your API Endpoint
    .setProject('5df5acd0d48c2') // Your project ID
  ;
  Future result = databases.listDocuments(
    databaseId: '[DATABASE_ID]',
    collectionId: '[COLLECTION_ID]',
  );

  result
    .then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
  });
}
```
## HTTP Request

|Name | material     |     Type       | Description  |
|---- | ------------ | ---------------| ------------ |
|databaseId   | required   | string | Database ID.   |
|collectionId | required   | string | Collection ID. You can create a new collection using the Database service server integration. Make sure to define attributes before creating documents. |
|documentId   | required   | string | Document ID. Choose your own unique ID or pass the string ID.unique() to auto generate it. Valid chars are a-z, A-Z, 0-9, period, hyphen, and underscore. Can't start with a special char. Max length is 36 chars.|
|permissions|required|object|Document data as JSON object.|
|permissions  |   optional | array  |  An array of permissions strings. By default the current user is granted with all permissions. Learn more about permissions.| 


 **HTTP Response**

| Status Code |	  Content Type |  Payload |
|-----------|---------|----------|
| 201 Creates   |  application/json	    | Document Object |