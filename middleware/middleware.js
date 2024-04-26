const admin = require('firebase-admin');
const jwt = require('jsonwebtoken');
require('dotenv').config();


module.exports = async (req, res, next) => {
    try {
        // Check if the authorization header is present
        const authorizationHeader = req.headers['authorization'];

        if (!authorizationHeader) {
            return res.status(401).send({ message: 'Authorization header missing', success: false });
        }

        // Extract the token from the authorization header
        const token = authorizationHeader.split(' ')[1];

        // Verify the token
        const decoded = jwt.verify(token, "jhhhhhhg");

        const userId = decoded.id;

        // Assuming 'email' is the key you want to use to fetch the user document
        const userDoc = await admin.firestore().collection('users').doc(userId).get();

        if (!userDoc.exists) {
            return res.status(401).send({ message: 'User not found', success: false });
        }

        // Attach the user data to the request object
        req.user = userDoc.data();

        next();
    } catch (error) {
        res.status(401).send({ message: 'Auth failed', success: false });
    }
};
