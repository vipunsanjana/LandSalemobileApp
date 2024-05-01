const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const moment = require('moment');
const router = express.Router();
const uuid = require('uuid');
const admin = require("../db/firebase");
const firestore = admin.firestore();
const usersCollection = firestore.collection('users');
const addsCollection = firestore.collection('adds');
const multer = require('multer');
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });
const authMiddleware = require("../middleware/middleware");



router.post("/register", async (req, res) => {
  try {
    const { email, password } = req.body;

    // Check if the user with the provided email already exists
    const userSnapshot = await usersCollection.where('email', '==', email).get();

    if (!userSnapshot.empty) {
      return res.status(400).send({ message: "User Already Exists.", success: false });
    }

    // Generate a unique userId for the new user
    const userId = uuid.v4();

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Save the user data with userId as document ID
    await usersCollection.doc(userId).set({
      userId,
      email,
      password: hashedPassword,
      role: 'user', 
    });

    res.status(200).send({ message: "User Registered Successfully.", success: true });
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "User Registration Error.", success: false, error });
  }
});



// Define the logout route
router.post("/logout",authMiddleware, async (req, res) => {
  try {

    req.session.destroy();
    res.status(200).send({ message: "Logout Successful.", success: true });
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "Error Logging Out.", success: false, error });
  }
});


router.get('/profile/:userId',authMiddleware, async (req, res) => {
  const { userId } = req.params;
  try {
    const userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      return res.status(404).json({ error: 'User not found' });
    }
    const userData = userDoc.data();
    res.status(200).json({ success: true, user: userData });
  } catch (error) {
    console.error('Error fetching user profile:', error);
    res.status(500).json({ error: 'Failed to fetch user profile' });
  }
});




router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    // Query the Firestore collection based on the provided email
    const userSnapshot = await usersCollection.get();

    // Find the user with the provided email
    const userData = userSnapshot.docs.find(doc => doc.data().email === email);

    // Check if a user with the provided email exists
    if (!userData) {
      return res.status(200).send({ message: "User Does not Exist.", success: false });
    }

    // Compare the provided password with the hashed password from the database
    const isMatch = await bcrypt.compare(password, userData.data().password);

    // If passwords match, generate JWT token for authentication
    if (isMatch) {
      const secretKey = process.env.key || "jhhhhhhg";
      const token = jwt.sign({ id: userData.data().userId, email }, secretKey, {
        expiresIn: "1d",
      });

      // Send success response with token and user data
      return res.status(200).send({
        success: true,
        message: "Login Successful.",
        user: {
          userId: userData.data().userId,
          email: userData.data().email,
          role: userData.data().role,
        },
        token,
      });
    } else {
      // If passwords don't match, return error message
      return res.status(200).send({ message: "Password is Incorrect.", success: false });
    }
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "Error Logging In.", success: false, error });
  }
});



router.get("/get-approved-adds", async (req, res) => {
  try {
      const snapshot = await addsCollection.where("isApproved", "==", true).get();

      if (snapshot.empty) {
          res.status(404).send({ message: "No approved adds found.", success: false });
          return;
      }

      const approvedAdds = snapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data(),
      }));

      res.status(200).send({ message: "Approved adds fetched successfully.", success: true, data: approvedAdds });
  } catch (error) {
      console.error(error);
      res.status(500).send({ message: "Error fetching approved adds.", success: false, error: error.message });
  }
});





router.post("/create-add/:userId", upload.single('image'), async (req, res) => {
  try {
    const { name, description, price, from } = req.body;
    const userId = req.params.userId; // Extract user ID from the route parameter
    //console.log("first");
    //const imageData = req.file.buffer;
    // Convert image data to base64
    //const base64Image = imageData.toString('base64');
    //console.log(imageData);

    // console.log(base64Image)
    // console.log(req.file.mimetype)

    // Check if required fields are provided
    if (!name || !description || !price || !from) {
      return res.status(500).send({ error: "All fields are required" });
    }



    // Create the ad
    const addRef = await addsCollection.add({
      name,
      description,
      price,
      from,
      userId, // Associate the ad with the user who created it
      // image: {
      //   data: base64Image,
      //   contentType: req.file.mimetype,
      // },
      isApproved: false,
    });

    res.status(200).send({ message: "Ad Created Successfully.", success: true, id: addRef.id });

  } catch (error) {
    console.error(error);
    res.status(500).send({
      success: false,
      error,
      message: "Error in creating ad",
    });
  }
});







module.exports = router;
