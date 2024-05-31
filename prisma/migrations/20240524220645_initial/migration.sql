/*
  Warnings:

  - You are about to drop the `Comment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Ingredient` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IngredientInRecipe` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Like` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Recipe` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Recipe_Type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_id_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_id_post_fkey";

-- DropForeignKey
ALTER TABLE "IngredientInRecipe" DROP CONSTRAINT "IngredientInRecipe_ingredientId_fkey";

-- DropForeignKey
ALTER TABLE "IngredientInRecipe" DROP CONSTRAINT "IngredientInRecipe_recipeId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_id_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_id_post_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_idRecipe_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_recipeTypeId_fkey";

-- DropForeignKey
ALTER TABLE "Recipe" DROP CONSTRAINT "Recipe_recipeTypeId_fkey";

-- DropTable
DROP TABLE "Comment";

-- DropTable
DROP TABLE "Ingredient";

-- DropTable
DROP TABLE "IngredientInRecipe";

-- DropTable
DROP TABLE "Like";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "Recipe";

-- DropTable
DROP TABLE "Recipe_Type";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "pseudo" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "isadmin" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recipe" (
    "id_recipe" TEXT NOT NULL,
    "time_of_preparation" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "number_of_person" INTEGER NOT NULL,
    "recipetypeid" TEXT NOT NULL,

    CONSTRAINT "recipe_pkey" PRIMARY KEY ("id_recipe")
);

-- CreateTable
CREATE TABLE "recipe_type" (
    "id_recipe_type" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "recipe_type_pkey" PRIMARY KEY ("id_recipe_type")
);

-- CreateTable
CREATE TABLE "ingredient" (
    "id_ingredient" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "ingredient_pkey" PRIMARY KEY ("id_ingredient")
);

-- CreateTable
CREATE TABLE "ingredientinrecipe" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit" TEXT NOT NULL,
    "recipeid" TEXT NOT NULL,
    "ingredientid" TEXT NOT NULL,

    CONSTRAINT "ingredientinrecipe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "post" (
    "id_post" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "id_user" TEXT NOT NULL,
    "idrecipe" TEXT NOT NULL,
    "recipetypeid" TEXT NOT NULL,

    CONSTRAINT "post_pkey" PRIMARY KEY ("id_post")
);

-- CreateTable
CREATE TABLE "comment" (
    "id_comment" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "id" TEXT NOT NULL,
    "id_post" TEXT NOT NULL,

    CONSTRAINT "comment_pkey" PRIMARY KEY ("id_comment")
);

-- CreateTable
CREATE TABLE "like" (
    "id_like" TEXT NOT NULL,
    "id" TEXT NOT NULL,
    "id_post" TEXT NOT NULL,

    CONSTRAINT "like_pkey" PRIMARY KEY ("id_like")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- AddForeignKey
ALTER TABLE "recipe" ADD CONSTRAINT "recipe_recipetypeid_fkey" FOREIGN KEY ("recipetypeid") REFERENCES "recipe_type"("id_recipe_type") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ingredientinrecipe" ADD CONSTRAINT "ingredientinrecipe_recipeid_fkey" FOREIGN KEY ("recipeid") REFERENCES "recipe"("id_recipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ingredientinrecipe" ADD CONSTRAINT "ingredientinrecipe_ingredientid_fkey" FOREIGN KEY ("ingredientid") REFERENCES "ingredient"("id_ingredient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post" ADD CONSTRAINT "post_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post" ADD CONSTRAINT "post_idrecipe_fkey" FOREIGN KEY ("idrecipe") REFERENCES "recipe"("id_recipe") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post" ADD CONSTRAINT "post_recipetypeid_fkey" FOREIGN KEY ("recipetypeid") REFERENCES "recipe_type"("id_recipe_type") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comment" ADD CONSTRAINT "comment_id_fkey" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comment" ADD CONSTRAINT "comment_id_post_fkey" FOREIGN KEY ("id_post") REFERENCES "post"("id_post") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "like" ADD CONSTRAINT "like_id_fkey" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "like" ADD CONSTRAINT "like_id_post_fkey" FOREIGN KEY ("id_post") REFERENCES "post"("id_post") ON DELETE RESTRICT ON UPDATE CASCADE;
