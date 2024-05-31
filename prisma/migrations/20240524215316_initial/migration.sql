/*
  Warnings:

  - You are about to drop the column `Description` on the `Recipe` table. All the data in the column will be lost.
  - You are about to drop the column `Name` on the `Recipe` table. All the data in the column will be lost.
  - You are about to drop the column `Number_Of_Person` on the `Recipe` table. All the data in the column will be lost.
  - Added the required column `description` to the `Recipe` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Recipe` table without a default value. This is not possible if the table is not empty.
  - Added the required column `number_of_person` to the `Recipe` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Recipe" DROP COLUMN "Description",
DROP COLUMN "Name",
DROP COLUMN "Number_Of_Person",
ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "number_of_person" INTEGER NOT NULL;
