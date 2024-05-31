/*
  Warnings:

  - You are about to drop the column `idReceip` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the `IngredientInReceip` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Material` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MaterialInReceip` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Receip` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `idRecipe` to the `Post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `recipeTypeId` to the `Post` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "IngredientInReceip" DROP CONSTRAINT "IngredientInReceip_ingredientId_fkey";

-- DropForeignKey
ALTER TABLE "IngredientInReceip" DROP CONSTRAINT "IngredientInReceip_receipId_fkey";

-- DropForeignKey
ALTER TABLE "MaterialInReceip" DROP CONSTRAINT "MaterialInReceip_materialId_fkey";

-- DropForeignKey
ALTER TABLE "MaterialInReceip" DROP CONSTRAINT "MaterialInReceip_receipId_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_idReceip_fkey";

-- AlterTable
ALTER TABLE "Post" DROP COLUMN "idReceip",
ADD COLUMN     "idRecipe" TEXT NOT NULL,
ADD COLUMN     "recipeTypeId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "isAdmin" BOOLEAN NOT NULL DEFAULT false;

-- DropTable
DROP TABLE "IngredientInReceip";

-- DropTable
DROP TABLE "Material";

-- DropTable
DROP TABLE "MaterialInReceip";

-- DropTable
DROP TABLE "Receip";

-- CreateTable
CREATE TABLE "Recipe" (
    "id_recipe" TEXT NOT NULL,
    "Time_Of_Preparation" TIMESTAMP(3) NOT NULL,
    "Name" TEXT NOT NULL,
    "Description" TEXT NOT NULL,
    "Number_Of_Person" INTEGER NOT NULL,
    "recipeTypeId" TEXT NOT NULL,

    CONSTRAINT "Recipe_pkey" PRIMARY KEY ("id_recipe")
);

-- CreateTable
CREATE TABLE "Recipe_Type" (
    "id_recipe_type" TEXT NOT NULL,
    "Name" TEXT NOT NULL,

    CONSTRAINT "Recipe_Type_pkey" PRIMARY KEY ("id_recipe_type")
);

-- CreateTable
CREATE TABLE "IngredientInRecipe" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit" TEXT NOT NULL,
    "recipeId" TEXT NOT NULL,
    "ingredientId" TEXT NOT NULL,

    CONSTRAINT "IngredientInRecipe_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Recipe" ADD CONSTRAINT "Recipe_recipeTypeId_fkey" FOREIGN KEY ("recipeTypeId") REFERENCES "Recipe_Type"("id_recipe_type") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientInRecipe" ADD CONSTRAINT "IngredientInRecipe_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id_recipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientInRecipe" ADD CONSTRAINT "IngredientInRecipe_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("id_ingredient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_idRecipe_fkey" FOREIGN KEY ("idRecipe") REFERENCES "Recipe"("id_recipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_recipeTypeId_fkey" FOREIGN KEY ("recipeTypeId") REFERENCES "Recipe_Type"("id_recipe_type") ON DELETE RESTRICT ON UPDATE CASCADE;
