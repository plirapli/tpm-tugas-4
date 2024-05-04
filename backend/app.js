require("dotenv").config();
const express = require("express");
const cors = require("cors");
const userRouter = require("./router/users");
const favoriteRouter = require("./router/favorites");
const port = process.env.PORT || "3100";
const app = express();

app.use(cors());
app.use(express.json());
app.use("/v1/users", userRouter);
app.use("/v1/favorites", favoriteRouter);

app.listen(port, () => {
  console.log("Server Connected on: http://localhost:" + port + "/");
});
