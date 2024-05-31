/*
  Warnings:

  - Changed the type of `time_of_preparation` on the `recipe` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "recipe" DROP COLUMN "time_of_preparation",
ADD COLUMN     "time_of_preparation" INTEGER NOT NULL;
