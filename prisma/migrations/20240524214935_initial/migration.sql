/*
  Warnings:

  - You are about to drop the column `Time_Of_Preparation` on the `Recipe` table. All the data in the column will be lost.
  - Added the required column `time_of_preparation` to the `Recipe` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Recipe" DROP COLUMN "Time_Of_Preparation",
ADD COLUMN     "time_of_preparation" TIMESTAMP(3) NOT NULL;
