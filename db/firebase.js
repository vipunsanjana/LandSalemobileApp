const admin = require('firebase-admin');
const serviceAccount = require('../serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://doctor-web-40125.firebaseio.com',
  projectId: 'doctor-web-40125',
});

console.log('Firebase Firestore connected');

module.exports = admin;


// require('dotenv').config();

// const admin = require('firebase-admin');

// // Initialize Firebase Admin SDK with the credentials from serviceAccountKey.json
// admin.initializeApp({
//   credential: admin.credential.cert({
//     project_id: process.env.PROJECT_ID,
//     private_key: process.env.PRIVATE_KEY.replace(/\\n/g, '\n'), // Replace escaped newline characters
//     client_email: process.env.CLIENT_EMAIL,
//   }),
//   databaseURL: `https://${process.env.PROJECT_ID}.firebaseio.com`, // Use your database URL
// });

// console.log('Firebase Firestore connected');

// module.exports = admin;
