const express = require('express');
const User = require('../models/user');
var bcryptjs = require('bcryptjs');
var jwt = require('jsonwebtoken');
const authRouter = express.Router();
const auth = require("../middleware/auth");

//authRouter.get('/abc', (req, res)=>{
//    res.send(200);
//})

authRouter.post('/api/signup',async (req, res) => {
try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    if(password.length < 6){
        res.status(500).json({ error: "Password must be at least 6 characters"});
    }
    else{
    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  }
  } catch (e) {
    res.status(500).json({ error: e.message });
}

});

authRouter.post('/api/signin', async (req, res) => {
try{
  const { email, password } = req.body;
  const user = await User.findOne({ email });
  if(!user){
  return res.status(400).json({ msg: "User not found!" });
  }
  const isMatch = await bcryptjs.compare(password, user.password);
  if(!isMatch){
  return res.status(400).json({ msg: "Invalid password!" });
  }

  const token = jwt.sign({id: user._id},"passwordKey",);
  res.json({ token, ...user._doc });

}
catch(e){
  res.status(500).json({ error: e.message });
}
  });

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
