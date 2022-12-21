// Importa el SDK de Firebase para Google Cloud Functions.
const functions = require('firebase-functions');

// Importa e inicializa el SDK de Firebase Admin.
const admin = require('firebase-admin');
admin.initializeApp();

//Envía una notificación al cliente cuando se inserta un nuevo documento en notificacion
//Ejemplo cuando se actualiza el estado de un pedido(actualiza el estado se inserta un nuevo documento de notificacion).
exports.enviarNotificacionAlActualizarEstadoPedido = functions.firestore.document('notificacion/{uid}')
.onCreate(async (snapshot) => {
    if (snapshot.exists) {
       console.log('>>>>>>>Existe');
      }  
 
  // Datos de la notificacion
  var payload = {    notification: {   title:'GasJ&M',    body:snapshot.data().tituloNotificacion +' por '+snapshot.data().textoNotificacion,}, }  ;

 // Obtener el uid del receptor de la notificacion
 var uidPersona=snapshot.data().idRemitenteNotificacion;

 // Obtener la lista de tokens de dispositivos.
 const datoPersona = await admin.firestore().collection("persona").doc(uidPersona).get(); 
 const listaTokens =  datoPersona.get("tokensParaNotificacion"); 
 
 if (listaTokens.length > 0) {
  //Enviar notificacion a todos los tokens 
try {
  console.log(">>>>Enviando");

  const response=await admin.messaging().sendToDevice(listaTokens,payload);

  //Se enviaron notificaciones y se limpiaron los tokens.
  await limpiarTokensNoValidos(response, listaTokens,uidPersona);
  console.log(">>>>Enviado");
} catch (error) {
  console.log( error.code);
  console.log(">>>>Error "+error.message);
  
} 
}

  //var token='fE4s_iLQQ4-OINqX2GsVa-:APA91bFHZnxcKyNtkbCM_5Dvdn_Yut4jKc6MJUEMRSctqxG5CFaLIdNhFAxWedl0wME1t0jTjJ5pwAB4_XN0jwsL7Ll0fVG1TWlEoPFgR5FafncboeAMfcihXAbtrMUNY0jXVtALvL1Q';

}); 

//Limpia los tokens que ya no son válidos.
function limpiarTokensNoValidos(response, tokens,uid) {
  // Para cada notificación verificamos si hubo un error.
  const tokensDelete = [];
  response.results.forEach((result, index) => {
    const error = result.error;
    if (error) {
      functions.logger.error('Error al enviar notificación a', tokens[index], error);
      // Limpie los tokens que ya no están registrados.
      if (error.code === 'messaging/invalid-registration-token' ||
          error.code === 'messaging/registration-token-not-registered') {
        const deleteTask = admin.firestore().collection("persona").doc(uid).update({
          "tokensParaNotificacion": FieldValue.arrayRemove([tokens[index]]),    });
        tokensDelete.push(deleteTask);
      }
    }
  });
  return Promise.all(tokensDelete);
 }