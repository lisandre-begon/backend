const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const { getAllRecipes, createRecipe, deleteRecipe, getIngredientsByRecipeId, getRandomRecipe } = require('../models/recipeModels');

exports.getRecipes = async (req, res) => {
    try {
        const recipes = await getAllRecipes();
        res.json(recipes);
    } catch (error) {
        res.status(500).json({ error: `Failed to fetch recipes: ${error.message}` });
    }
};

exports.getRandomRecipe = async (req, res) => {
    try {
        const randomRecipe = await getRandomRecipe(); // Use the function from the models
        res.json(randomRecipe);
    } catch (error) {
        res.status(500).json({ error: `Failed to fetch a random recipe: ${error.message}` });
    }
};

exports.addRecipe = async (req, res) => {
    try {
        const data = req.body;
        const recipe = await createRecipe(data);
        res.status(201).json({ message: 'Recipe created', recipe });
    } catch (error) {
        res.status(500).json({ error: `Failed to create recipe: ${error.message}` });
    }
};

exports.removeRecipe = async (req, res) => {
    try {
        const { id } = req.params;
        const recipe = await deleteRecipe(id);
        res.json({ message: 'Recipe deleted', recipe });
    } catch (error) {
        res.status(500).json({ error: `Failed to delete recipe: ${error.message}` });
    }
};

exports.getIngredientsInRecipe = async (req, res) => {
    try {
        const { id_recipe } = req.params;
        const ingredients = await getIngredientsByRecipeId(id_recipe);
        res.json(ingredients);
    } catch (error) {
        res.status(500).json({ error: `Failed to fetch ingredients: ${error.message}` });
    }
};
