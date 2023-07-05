require('dotenv').config();

const express = require("express");
const mongoose = require("mongoose");
const app = express();
const PORT = process.env.PORT || 1509 ;
const DB = "mongodb+srv://basit:basitali1509@cluster0.n7zmkqj.mongodb.net/?retryWrites=true&w=majority";

// Import from other files
const authRouter  = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/products');
const userRouter = require('./routes/user');

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections



mongoose.connect(DB).then(() => {
    console.log("connected to database");

}).catch(
err =>{
    console.log(err);
    });

app.listen(PORT, () =>{
console.log("connected at port", PORT);
})

// creating api
//app.get("/", (req,res) => {
//
//
//    res.json({
//        name: "Basit" });
//});
//app.get("/hello-world", (req,res) => {
//    res.send("Hello World")
//});

