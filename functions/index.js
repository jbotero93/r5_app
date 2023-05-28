const functions = require("firebase-functions");
const {Translate} = require("@google-cloud/translate").v2;
const admin = require("firebase-admin");

admin.initializeApp();

const translate = new Translate();

exports.translateText = functions.firestore
    .document("{userId}/{taskId}")
    .onCreate(async (snapshot, context) => {
    // Obtiene el texto de la tarea creada
      const task = snapshot.data();
      const content = task.content;
      const title = task.title;
      const taskId = snapshot.id;
      const userId = task.uid;

      // Traduce el texto a inglés
      const [cTranslation] = await translate.translate(content, "en");
      const [tTranslation] = await translate.translate(title, "en");

      // Actualiza el campo de texto en inglés en Firestore
      await snapshot.ref.set({titleTranslated: tTranslation}, {merge: true});
      await snapshot.ref.set({contentTranslated: cTranslation}, {merge: true});
      console.log(`Texto traducido: ${tTranslation}`);
    });
