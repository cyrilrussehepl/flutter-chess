# AsyncChess

# Documentation


## 📁 Présentation des Principaux Dossiers

Le dossier `lib` de ce projet est organisé de manière à séparer clairement les différentes responsabilités et fonctionnalités de l'application **AsyncChess**. Voici une présentation des principaux dossiers et fichiers présents dans le projet :

- **screens/** : Ce dossier contient les différentes pages (écrans) de l'application. Chaque écran est organisé en sous-dossiers en fonction de leur domaine fonctionnel :
   - **authentication/** : Contient les écrans liés à l'authentification des utilisateurs, comme `sign_in.dart` et `sign_up.dart`.
   - **game/** : Contient les écrans liés à la gestion des parties d'échecs, comme `game.dart`.
   - **main/tabs/** : Contient les différents onglets principaux de l'application, tels que la liste des amis, les invitations, et les profils utilisateurs.

- **services/** : Ce dossier regroupe les services utilisés dans l'application pour gérer des fonctionnalités spécifiques, telles que l'authentification des utilisateurs ou la gestion des données utilisateur.
   - **authentication_services.dart** : Gère les opérations liées à l'authentification.
   - **user_services.dart** : Gère la récupération et la mise à jour des données utilisateur.

- **style/** : Ce dossier contient les fichiers de style de l'application, incluant les couleurs, les styles de texte, et le thème global de l'application.
   - **color.dart** : Définit les couleurs utilisées dans l'application.
   - **text_styles.dart** : Contient les styles de texte communs à l'application.
   - **theme.dart** : Regroupe les paramètres de thème global pour l'application.

- **widgets/** : Ce dossier contient les widgets réutilisables dans l'application, organisés en sous-dossiers par domaine fonctionnel :
   - **authentication/** : Contient des widgets spécifiques à l'authentification, comme `auth_button.dart` et `text_input_field.dart`.
   - **chess/** : Contient des widgets liés au jeu d'échecs, comme `chess.dart` et `square.dart`.
   - **custom_list/** : Contient des widgets personnalisés pour les listes, comme `list_view.dart` et `list_tile_actions.dart`.

- **firebase_options.dart** : Ce fichier contient les configurations spécifiques à Firebase pour le projet.

- **routes.dart** : Définit les routes de navigation pour l'application, facilitant le passage entre les différents écrans.


## 🚀 Présentation de l'Application

:chess_pawn: **AsyncChess** est une application de jeu d'échecs en différé, développée dans le cadre d'un projet académique pour lequel j'ai choisi de créer un jeu d'échecs. Elle permet aux utilisateurs de jouer des parties à leur rythme avec d'autres joueurs de la communauté. L'interface a été conçue pour être intuitive et facile à utiliser, offrant toutes les fonctionnalités essentielles pour profiter du jeu en ligne. AsyncChess se veut accessible et agréable pour tous les amateurs d'échecs souhaitant jouer en toute simplicité.


## 🌐 Étude de l'Existant

Les échecs étant un jeu de société extrêmement connu, il existe déjà de nombreuses applications en ligne telles que Chess.com ou Lichess.org, qui offrent des fonctionnalités avancées comme l'analyse des parties, les compétitions en ligne, et les matchs contre des intelligences artificielles de différents niveaux. Ces plateformes sont devenues des références incontournables pour les joueurs de tous niveaux.

Je suis pleinement conscient que mon application AsyncChess ne cherche pas à rivaliser avec ces géants du domaine, qui proposent des services bien plus complexes et complets. Cependant, c'est avant tout par passion pour les échecs que j'ai choisi de développer cette application. Mon objectif était de créer une version plus simple et accessible, où les joueurs peuvent profiter de parties en différé, sans la pression du temps, tout en maintenant une connexion sociale avec d'autres amateurs d'échecs.


## 📋 Fonctionnalités

>En tant qu'utilisateur inscrit, je veux pouvoir **jouer des parties d'échecs en différé** avec d'autres utilisateurs afin de profiter du jeu à mon rythme, sans contrainte de temps.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\playAMove.png" width="300"/>

>En tant qu'utilisateur inscrit, je veux pouvoir **consulter et gérer ma liste d'amis** afin de défier mes contacts et rester en contact avec eux dans l'application.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\FriendList.png" width="300"/>

>En tant qu'utilisateur inscrit, je veux recevoir et **répondre à des invitations à jouer** des parties afin de facilement lancer des jeux avec mes amis ou d'autres joueurs.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\ChallengeReceived.png" width="300"/>

>En tant qu'utilisateur, je veux pouvoir consulter mon profil et **mettre à jour mes informations personnelles**, telles que mon nom complet et ma nationalité afin de garder mes informations à jour et refléter ma véritable identité dans le jeu.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\editProfile.png" width="300"/>

>En tant qu'utilisateur, je veux avoir la possibilité de **personnaliser** mon profil avec une **photo de profil** afin de rendre mon compte plus personnel et identifiable par les autres joueurs.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\updateProfilPicture.png" width="300"/>

>En tant qu'utilisateur inscrit, je veux pouvoir consulter l'**historique de mes parties** terminées.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\Parties_finies.png" width="300"/>

>En tant qu'utilisateur non identifié, je veux **pouvoir m'inscrire** facilement via une interface simple afin de créer un compte et commencer à jouer rapidement.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\Inscriptions.png" width="300"/>

>En tant qu'utilisateur inscrit, je veux **pouvoir me connecter à mon compte** afin de retrouver mes parties en cours, mes amis, et toutes mes données personnelles.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\Connexion.png" width="300"/>

>En tant qu'utilisateur inscrit, je veux pouvoir rechercher d'autres utilisateurs dans l'application afin de les ajouter à ma liste d'amis.
>
><img alt="Capture d&#39;écran de l&#39;application" src="\ImagesDocumentation\searchUser.png" width="300"/>


## 📈 État d'Avancement

> :heavy_check_mark: : Création d'une page de connexion et d'inscription

> :heavy_check_mark: : Création de compte ou connexion à un compte existant avec FirebaseAuth

> :heavy_check_mark: : Création de la page principale avec un bottomNavigationBar comprenant 3 onglets (parties, amis, profil)

> :heavy_check_mark: : Création du package **dto** avec User et update de l'id(auth) lors de l'inscription ainsi que la création du package **load_data_to_firestore**. Gestion des authentifications avec FirebaseAuth dans `authentication_services.dart`. 
> 
> _Exemple d'utilisateur fictif **adam**_
> ```dart
> User(
>   username: 'adam',
>   usernameLowerCase: 'adam',
>   fullName: "Adam Ondra",
>   nationality: "",
>   email: "Adam@example.com",
>   friends: [
>     'janjaTheGoat',
>     'LightningBolt'
>   ],
>   sentFriendRequests: [],
>   receivedFriendRequests: [],
>   sentChallengeRequests: [],
>   receivedChallengeRequests: [],
>   gamesOnGoing: [
>     GameInfo(gameId: 'game1', opponent: 'janjaTheGoat', victory: 'ongoing'),
>   ],
>   gamesOver: []
> )
> ```

> :heavy_check_mark: : Ajout d'un 4ᵉ onglet avec les défis reçus et en attentes

> :heavy_check_mark: : Création de liste générique pour afficher amis, parties et défis

> :heavy_check_mark: : Fonctionnalités d'ajouts d'amis, lancer un défi, recherche d'amis et liaison avec Firestore à l'aide de fonctions dans user_services

> :heavy_check_mark: : Gestion du profil, page de profil et gestion de photo de profil avec appareil photo ou depuis la librairie, le tout upload dans FireStorage

> :heavy_check_mark: : Création des parties, dto Game et gestion avec game_services
>
> _Exemple de partie fictive **game1**_
> ```dart
> Game(
>   gameId: 'game1',
>   playerWhite: 'janjaTheGoat',
>   playerBlack: 'adam',
>   currentTurn: 'white',
>   gameState: 'ongoing',
>   moves: ['e2e4', 'e7e5', 'g1f3'],
>   boardState: [
>     'r', 'n', 'b', 'q', 'k', 'b', 'n', 'r',
>     'p', 'p', 'p', null, 'p', 'p', 'p', 'p',
>     null, null, null, null, null, null, null, null,
>     null, null, null, 'p', null, null, null, null,
>     null, null, null, 'P', null, null, null, null,
>     null, null, 'N', null, null, null, null, null,
>     'P', 'P', 'P', null, 'P', 'P', 'P', 'P',
>     'R', null, 'B', 'Q', 'K', 'B', 'N', 'R',
>   ],
> )
> ```

> :heavy_check_mark: : Intégration du jeu d'échec préparé en amont dans un projet flutter indépendant


## ⚙️ Compilation de l'Application

Pour compiler l'application **AsyncChess**, suivez les étapes ci-dessous :

1. **Cloner le dépôt** : Clonez le dépôt Git sur votre machine locale.
   ```bash
   git clone https://github.com/trans-dam-2023-2024/russe_cyril_asyncChess_flutter.git
   cd russe_cyril_asyncChess_flutter/code/projet_chess/
   ```

2. **Installer les dépendances** : Assurez-vous d'avoir Flutter installé sur votre machine. Ensuite, installez les dépendances du projet en exécutant la commande suivante dans le répertoire racine du projet.
   ```bash
   flutter pub get
   ```

3. **Configurer Firebase** : Le projet utilise Firebase pour l'authentification et le stockage. Vous devez configurer Firebase pour votre propre projet.
    - Créez un projet Firebase depuis la console Firebase.
    - Ajoutez les configurations nécessaires (`GoogleService-Info.plist` pour iOS et `google-services.json` pour Android) dans les dossiers `ios/Runner` et `android/app` respectivement.
    - Activez les services Firebase requis comme l'authentification et le Firestore.

4. **Exécuter l'application** : Après avoir configuré Firebase, vous pouvez exécuter l'application sur un simulateur ou un appareil physique en utilisant la commande suivante :
   ```bash
   flutter run
   ```

5. **Compiler pour la distribution** :
    - Pour Android :
      ```bash
      flutter build apk
      ```
    - Pour iOS :
      ```bash
      flutter build ios
      ```

Ces étapes devraient vous permettre de compiler et exécuter l'application **AsyncChess** sans problème. Si vous rencontrez des erreurs ou des problèmes, vérifiez les configurations de votre environnement de développement ou consultez la documentation Flutter pour plus de détails.
Il peut être nécessaire d'ajouter aussi des permissions, par exemple dans le fichier `AndroidManifest.xml`