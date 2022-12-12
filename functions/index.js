// The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
//
var newData;
admin.initializeApp();
exports.sendNotification = functions.firestore.document('notificacion/{uid}')
.onCreate(async (change) => {
    if (change.exists) {
       console.log('>>>>>>>Existe');
      }
 
 
//
  //var token ='fsh7GFhiTIyA32LqURHSwz:APA91bFhaHhaGz8N5pvjdIoJiGp6HOwNsBNcI4RZ10QakdadlHgU0DTdbERXmSc8-q7MeNlQ2FJYbNOABJyyop9BHWK-uNzCcV2MANC0nyElx9XKVSHMXbUqpAO1kQkQQM1EaIhbO9sC';
  var token='fE4s_iLQQ4-OINqX2GsVa-:APA91bFHZnxcKyNtkbCM_5Dvdn_Yut4jKc6MJUEMRSctqxG5CFaLIdNhFAxWedl0wME1t0jTjJ5pwAB4_XN0jwsL7Ll0fVG1TWlEoPFgR5FafncboeAMfcihXAbtrMUNY0jXVtALvL1Q';
//
newData=change.data;
 
  // Notification details.
  var payload = {
    notification: {   title:change.data().name,    body:'Push body',},
    data:{click_action:'FLUTTER_NOTIFICATION_CLICK',  message: 'Hola'},

     // icon: follower.photoURL
    }
  ;
 //
 try {
    console.log(">>>>Enviando");

    const response=await admin.messaging().sendToDevice(token,payload);
    console.log(">>>>Enviado");
 } catch (error) {
    console.log(">>>>Error "+error.message);
    
 }
});
// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
