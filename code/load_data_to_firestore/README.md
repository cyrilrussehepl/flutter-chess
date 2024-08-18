# Load Data to Firestore

Ce projet a pour objectif de publier deux collections de données fictives dans une base de données Firestore. Les deux
collections sont les suivantes :

## Collection "users"

La collection "users" représente une série d'utilisateurs fictifs. Voici un exemple de données fictives pour cette
collection :

```dart
import 'package:dto/user.dart';

const List<User> users = [
  // Liste d'utilisateurs fictifs
  // ...
];
```

Outre le peuplement de la collection "users", le script enregistre également ces utilisateurs dans Firebase
Authentication.

Parmi les champs de Users, il y a la liste des parties liées à cet utilisateur sous forme d'une liste d'objet GameInfo.


## Collection "games"

La collection "games" représente une série de parties fictives. Voici un exemple de données fictives pour cette
collection :

```dart
import 'package:dto/user.dart';

const List<Game> games = [
  // Liste de parties fictives
  // ...
];
```

## Utilisation

Pour utiliser ce projet, il suffit de cloner le projet et de l'exécuter. Il est nécessaire d'avoir un compte Firebase,
de créer un projet Firebase et d'ajouter une base de données. Si vous avez correctement configuré Firebase CLI, vous
pouvez exécuter la commande suivante :

```bash
firebase firestore:delete --all-collections --project flutter-chess-1af50
```

Ceci permet de supprimer les collections de la base données.

Ensuite, il suffit d'exécuter le projet. `main.dart`.



