const express = require("express");
const admin = require("../db/firebase");
const router = express.Router();
const authMiddleware = require("../middleware/middleware");
//const multer = require('multer');
const firestore = admin.firestore();
const moment = require('moment');
//const useersCollection = firestore.collection('users');
const addsCollection = firestore.collection('adds');
const usersCollection = firestore.collection('users');

// const storage = multer.memoryStorage();
// const upload = multer({ storage: storage });





//   router.post("/create-doctor", authMiddleware, upload.single('image'), async (req, res) => {
//   try {
//     const { name, description, price, from, to, date } = req.body;

//     if (!req.file) {
//       return res.status(400).send({ error: "Image is Required" });
//     }
    
//     const imageData = req.file.buffer;

//     switch (true) {
//       case !name:
//         return res.status(500).send({ error: "Name is Required" });
//       case !description:
//         return res.status(500).send({ error: "Description is Required" });
//       case !price:
//         return res.status(500).send({ error: "Price is Required" });
//       case !from:
//         return res.status(500).send({ error: "From is Required" });
//       case !to:
//         return res.status(500).send({ error: "To is Required" });
//       case !date:
//         return res.status(500).send({ error: "Date is Required" });

//     }

//     const doctorSnapshot = await doctorsCollection.doc().get();
//     const doctorId = doctorSnapshot.id;

//     const adjustedFrom = moment(from).subtract(2, 'hours').format('HH:mm:ss');


//     const base64Image = imageData.toString('base64');

//     await doctorsCollection.doc(doctorId).set({
//       name,
//       description,
//       price,
//       from,
//       to,
//       date,
//       adjustedFrom,
//       image: {
//         data: base64Image,
//         contentType: req.file.mimetype,
//       },
//       isbook: false,
//     });

//     res.status(200).send({ message: "Doctor Created Successfully.", success: true });

//   } catch (error) {
//     console.log(error);
//     res.status(500).send({
//       success: false,
//       error,
//       message: "Error in creating doctor",
//     });
//   }
// });


router.get('/profile/:userId', async (req, res) => {
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




  

router.get("/get-all-adds", async (req, res) => {
    try {
        const snapshot = await addsCollection.get();

        if (snapshot.empty) {
            res.status(404).send({ message: "No adds found.", success: false });
            return;
        }

        const adds = snapshot.docs.map(doc => ({
            id: doc.id,
            ...doc.data(),
        }));

        res.status(200).send({ message: "adds fetched successfully.", success: true, data: adds });
    } catch (error) {
        console.error(error);
        res.status(500).send({ message: "Error fetching adds.", success: false, error: error.message });
    }
});






router.delete("/delete-add/:addId",authMiddleware, async (req, res) => {
  try {
    const addId = req.params.addId; 

    if (!addId) {
      return res.status(400).send({ error: "Add ID is required" });
    }

    const addRef = addsCollection.doc(addId);
    const addSnapshot = await addRef.get();

    if (!addSnapshot.exists) {
      return res.status(404).send({ error: "Add not found" });
    }

    await addRef.delete();

    res.status(200).send({ message: "Add deleted successfully.", success: true });

  } catch (error) {
    console.error(error);
    res.status(500).send({
      success: false,
      error,
      message: "Error deleting add",
    });
  }
});




router.put("/approve-add/:addId",authMiddleware, async (req, res) => {
  try {
      const addId = req.params.addId;
      
      await addsCollection.doc(addId).update({ isApproved: true });
      
      res.status(200).send({ message: "Add approved successfully.", success: true });
  } catch (error) {
      console.error(error);
      res.status(500).send({ message: "Error approving add.", success: false, error: error.message });
  }
});







module.exports = router;
