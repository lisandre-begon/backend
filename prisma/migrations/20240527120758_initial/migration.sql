/*
  Warnings:

  - You are about to drop the `comment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `like` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "comment" DROP CONSTRAINT "comment_id_fkey";

-- DropForeignKey
ALTER TABLE "comment" DROP CONSTRAINT "comment_id_post_fkey";

-- DropForeignKey
ALTER TABLE "like" DROP CONSTRAINT "like_id_fkey";

-- DropForeignKey
ALTER TABLE "like" DROP CONSTRAINT "like_id_post_fkey";

-- AlterTable
ALTER TABLE "recipe" ALTER COLUMN "description" DROP NOT NULL;

-- DropTable
DROP TABLE "comment";

-- DropTable
DROP TABLE "like";
