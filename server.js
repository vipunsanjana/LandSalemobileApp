const express = require("express");
const app = express();
const cors = require('cors');
app.use(express.json());
const bodyParser = require('body-parser'); 
require("./db/firebase");
const userRouter = require("./routes/userRoutes");
const adminRouter = require("./routes/adminRoutes");

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/api/user',userRouter);
app.use('/api/admin',adminRouter);


const port = process.env.PORT || 3002;

app.listen(port, () => {
    console.log(`Node server started at ${port}`);
})