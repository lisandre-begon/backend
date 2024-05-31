-- CreateTable
CREATE TABLE "User" (
    "id_user" TEXT NOT NULL,
    "pseudo" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id_user")
);

-- CreateTable
CREATE TABLE "Receip" (
    "id_receip" TEXT NOT NULL,
    "Receip_Type" TEXT NOT NULL,
    "Time_Of_Preparation" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Receip_pkey" PRIMARY KEY ("id_receip")
);

-- CreateTable
CREATE TABLE "Ingredient" (
    "id_ingredient" TEXT NOT NULL,
    "Name" TEXT NOT NULL,

    CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("id_ingredient")
);

-- CreateTable
CREATE TABLE "IngredientInReceip" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit" TEXT NOT NULL,
    "receipId" TEXT NOT NULL,
    "ingredientId" TEXT NOT NULL,

    CONSTRAINT "IngredientInReceip_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Material" (
    "id_material" TEXT NOT NULL,
    "Name" TEXT NOT NULL,

    CONSTRAINT "Material_pkey" PRIMARY KEY ("id_material")
);

-- CreateTable
CREATE TABLE "MaterialInReceip" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit" TEXT NOT NULL,
    "receipId" TEXT NOT NULL,
    "materialId" TEXT NOT NULL,

    CONSTRAINT "MaterialInReceip_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Post" (
    "id_post" TEXT NOT NULL,
    "Title" TEXT NOT NULL,
    "Content" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "id_user" TEXT NOT NULL,
    "idReceip" TEXT NOT NULL,

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id_post")
);

-- CreateTable
CREATE TABLE "Comment" (
    "id_comment" TEXT NOT NULL,
    "Content" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "id_user" TEXT NOT NULL,
    "id_post" TEXT NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id_comment")
);

-- CreateTable
CREATE TABLE "Like" (
    "id_like" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "id_post" TEXT NOT NULL,

    CONSTRAINT "Like_pkey" PRIMARY KEY ("id_like")
);

-- AddForeignKey
ALTER TABLE "IngredientInReceip" ADD CONSTRAINT "IngredientInReceip_receipId_fkey" FOREIGN KEY ("receipId") REFERENCES "Receip"("id_receip") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientInReceip" ADD CONSTRAINT "IngredientInReceip_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("id_ingredient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterialInReceip" ADD CONSTRAINT "MaterialInReceip_receipId_fkey" FOREIGN KEY ("receipId") REFERENCES "Receip"("id_receip") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterialInReceip" ADD CONSTRAINT "MaterialInReceip_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "Material"("id_material") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_idReceip_fkey" FOREIGN KEY ("idReceip") REFERENCES "Receip"("id_receip") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_id_post_fkey" FOREIGN KEY ("id_post") REFERENCES "Post"("id_post") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_id_post_fkey" FOREIGN KEY ("id_post") REFERENCES "Post"("id_post") ON DELETE RESTRICT ON UPDATE CASCADE;
