const express = require("express");
const router = express.Router();
const connection = require("../config");

// [GET] GET all favorite clubs by user_id
router.get("/:user_id", async (req, res, next) => {
  try {
    const { user_id } = req.params;

    if (!user_id) {
      const error = new Error("User ID cannot be empty.");
      error.statusCode = 400;
      throw error;
    }
    const query = `SELECT * FROM favorites WHERE user_id = ?`;
    let [favorites] = await connection.promise().query(query, [user_id]);
    favorites = favorites.map((fav) => fav.club_id);

    res.status(200).json({
      status: "Success",
      message: "Successfully get favorite clubs.",
      data: favorites,
    });
  } catch (error) {
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

// [POST] POST favorite club to user by user_id
router.post("/:user_id", async (req, res, next) => {
  try {
    const { user_id } = req.params;
    const { club_id } = req.body;

    if (!user_id || !club_id) {
      const error = new Error("Field Cannot be empty.");
      error.statusCode = 401;
      throw error;
    }
    if (club_id <= 0 || club_id > 20) {
      const error = new Error("Club not found.");
      error.statusCode = 404;
      throw error;
    }

    const checkQuery = `SELECT * FROM favorites WHERE user_id = ? AND club_id = ?`;
    const [favorites] = await connection
      .promise()
      .query(checkQuery, [user_id, club_id]);

    if (favorites.length > 0) {
      const error = new Error("Club already exist.");
      error.statusCode = 400;
      throw error;
    }

    const query = "INSERT INTO favorites (user_id, club_id) VALUES (?, ?)";
    await connection.promise().query(query, [user_id, club_id]);

    res.status(201).json({
      status: "Success",
      message: "Added to favorites.",
    });
  } catch (error) {
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

// [DELETE] Delete favorite club by user_id
router.delete("/:user_id", async (req, res, next) => {
  try {
    const { user_id } = req.params;
    const { club_id } = req.body;

    if (!user_id || !club_id) {
      const error = new Error("Cannot be empty.");
      error.statusCode = 401;
      throw error;
    }
    if (club_id <= 0 || club_id > 20) {
      const error = new Error("Club not found.");
      error.statusCode = 404;
      throw error;
    }

    const checkQuery = `SELECT * FROM favorites WHERE user_id = ? AND club_id = ?`;
    const [favorites] = await connection
      .promise()
      .query(checkQuery, [user_id, club_id]);

    if (favorites.length == 0) {
      const error = new Error("Club doesn't exist in favorites.");
      error.statusCode = 400;
      throw error;
    }

    const query = "DELETE FROM favorites WHERE user_id = ? AND club_id = ?";
    await connection.promise().query(query, [user_id, club_id]);

    res.status(200).json({
      status: "Success",
      message: "Deleted from favorites.",
    });
  } catch (error) {
    res.status(error.statusCode || 500).json({
      status: "Error",
      message: error.message,
    });
  }
});

module.exports = router;
