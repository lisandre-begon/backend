const express = require('express');
const { getRecipes, addRecipe, removeRecipe, getIngredientsInRecipe, getRandomRecipe } = require('../controllers/recipeControllers');

const router = express.Router();

router.get('/', getRecipes);
router.get('/random', getRandomRecipe);
router.post('/', addRecipe);
router.delete('/:id', removeRecipe);
router.get('/:id_recipe/ingredients', getIngredientsInRecipe); // Route pour obtenir les ingrédients d'une recette

module.exports = router;
