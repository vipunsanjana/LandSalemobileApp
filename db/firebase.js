const admin = require('firebase-admin');
const serviceAccount = require('../serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://doctor-web-40125.firebaseio.com',
  projectId: 'doctor-web-40125',
});

console.log('Firebase Firestore connected');

module.exports = admin;
