const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function getAllRecipes() {
    try {
        const recipes = await prisma.recipe.findMany({
            include: {
                ingredients: {
                    include: {
                        ingredient: true,
                    },
                },
                posts: true,
                recipetype: true,
            },
        });
        return recipes;
    } catch (error) {
        throw new Error(`Error fetching recipes: ${error.message}`);
    }
}

async function getRandomRecipe() {
    try {
        const recipes = await prisma.recipe.findMany({
            include: {
                ingredients: {
                    include: {
                        ingredient: true,
                    },
                },
                posts: true,
                recipetype: true,
            },
        });
        if (recipes.length === 0) {
            throw new Error("No recipes found in the database.");
        }
        // Select a random recipe
        const randomIndex = Math.floor(Math.random() * recipes.length);
        const randomRecipe = recipes[randomIndex];
        return randomRecipe;
    } catch (error) {
        console.error(`Failed to fetch random recipe: ${error.message}`);
        throw error;  // Rethrow to handle it in the calling context
    }
}

async function createRecipe(data) {
    try {
        // Check if all ingredients exist
        for (let ingredient of data.ingredients) {
            let existingIngredient = await prisma.ingredient.findUnique({
                where: { id: ingredient.id },
            });

            // If the ingredient doesn't exist, create it
            if (!existingIngredient) {
                await prisma.ingredient.create({
                    data: { id: ingredient.id, /* other ingredient data */ },
                });
            }
        }

        // Then, create the recipe with the ingredients
        const recipe = await prisma.recipe.create({
            data: {
                id_recipe: data.id_recipe,
                time_of_preparation: data.time_of_preparation,
                name: data.name,
                description: data.description,
                number_of_person: data.number_of_person,
                photo: data.photo,
                recipetypeid: data.recipetypeid,
                ingredients: {
                    create: data.ingredients.map(ingredient => ({
                        quantity: ingredient.quantity,
                        unit: ingredient.unit,
                        ingredientid: ingredient.id,
                    })),
                },
            },
        });

        return recipe;
    } catch (error) {
        throw new Error(`Error creating recipe: ${error.message}`);
    }
}

async function deleteRecipe(id) {
    try {
        const recipe = await prisma.recipe.delete({
            where: { id_recipe: id },
        });
        return recipe;
    } catch (error) {
        throw new Error(`Error deleting recipe: ${error.message}`);
    }
}

async function getIngredientsByRecipeId(recipeId) {
    try {
        const ingredients = await prisma.ingredientinrecipe.findMany({
            where: { recipeid: recipeId },
            include: {
                ingredient: true,
            },
        });
        console.log(`Ingredients for recipe ${recipeId}:`, ingredients);  // Log pour voir les ingrédients récupérés
        return ingredients;
    } catch (error) {
        console.error(`Error fetching ingredients for recipe ${recipeId}: ${error.message}`);
        throw error;
    }
}


module.exports = { getAllRecipes, createRecipe, deleteRecipe, getIngredientsByRecipeId, getRandomRecipe };
