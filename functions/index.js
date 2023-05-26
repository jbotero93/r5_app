const functions = require("firebase-functions");
const admin = require("firebase-admin");
const translate = require("@vitalets/google-translate-api");

admin.initializeApp();

exports.translateTask = functions.firestore
    .document("{userId}/{taskId}")
    .onCreate(async (snapshot, context) => {
      try {
        const taskData = snapshot.data();
        const taskText = taskData.texto;

        const userId = context.params.userId;
        const taskId = context.params.taskId;

        const translatedText = await translate(taskText, {to: "en"});

        const taskRef = snapshot.ref;
        await taskRef.update({textoTraducido: translatedText.text});

        console.log("Tarea traducida y actualizada:", taskRef.path);
      } catch (error) {
        console.error("Error al traducir la tarea:", error);
        // Realiza cualquier manejo de errores adicional que desees aquí
      }
    });
