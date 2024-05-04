const express = require("express");
const { nanoid } = require("nanoid");
const bcrypt = require("bcrypt");
const router = express.Router();
const connection = require("../config");

// [POST] Login existing user
router.post("/login", async (req, res, next) => {
  try {
    const { username, password } = req.body;
    if (!username || !password) {
      const error = new Error(`Username or password cannot be empty.`);
      error.statusCode = 400;
      throw error;
    }
    // Cek user ada apa engga
    const checkCommand = `SELECT * FROM users WHERE username = ?`;
    const [[user]] = await connection.promise().query(checkCommand, [username]);
    // If user doesn't exist
    if (!user) {
      const error = new Error("Wrong email or password");
      error.statusCode = 404;
      throw error;
    }
    const checkPassword = await bcrypt.compare(password, user.password);
    // Apabila password salah
    if (!checkPassword) {
      const error = new Error("Wrong email or password");
      error.statusCode = 404;
      throw error;
    }
    const { id, name } = user;
    const data = { id, name, username: user.username };
    res.status(200).json({
      status: "Success",
      message: "Login Successful",
      data,
    });
  } catch (error) {
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

// [POST] Register new user
router.post("/register", async (req, res, next) => {
  try {
    const { name, username, password } = req.body;

    if (!name || !username || !password) {
      const error = new Error(`Cannot be empty.`);
      error.statusCode = 400;
      throw error;
    }

    const salt = await bcrypt.genSalt(6);
    const hashedPassword = await bcrypt.hash(password, salt);
    const id = nanoid();

    // Cek apakah username udah ada atau engga
    const checkCommand = `SELECT id FROM users WHERE username = ?`;
    const [[checkId]] = await connection
      .promise()
      .query(checkCommand, [username]);

    if (checkId) {
      const error = new Error(`Username ${username} already exist!`);
      error.statusCode = 403;
      throw error;
    }

    // Insert data ke tabel User
    const query = `INSERT INTO users VALUES (?, ?, ?, ?)`;
    await connection
      .promise()
      .query(query, [id, name, username, hashedPassword]);

    // Send response
    res.status(201).json({
      status: "Success",
      message: "Register Successful",
    });
  } catch (error) {
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

module.exports = router;
