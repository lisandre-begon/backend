const express = require('express');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const morgan = require('morgan');
const indexRouter = require('./routes/indexRoutes');
const http = require('http');
const receiptRoutes = require('./routes/recipeRoutes');

const app = express();
const { checkAdmin } = require('./controllers/indexControllers');
const { verifyToken } = require('./controllers/verifyTokenControllers');

app.use(cookieParser());
app.use(morgan('dev'));

app.use(cors({
  origin: 'http://localhost:3000', // Adjust according to your frontend domain
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/', indexRouter);
app.use('/recipes', receiptRoutes);

app.get('/profil', verifyToken, async (req, res) => {
  const isAdmin = await checkAdmin(req, res);
  if (isAdmin) {
      res.redirect('/admin');
  } else {
      res.redirect('/');
  }
});

const port = process.env.SERVER_PORT || 5000; // Default to 5000 if SERVER_PORT is not defined
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
const server = http.createServer(app);
