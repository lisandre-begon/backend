/*
  Warnings:

  - You are about to drop the column `id_user` on the `Comment` table. All the data in the column will be lost.
  - You are about to drop the column `id_user` on the `Like` table. All the data in the column will be lost.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id_user` on the `User` table. All the data in the column will be lost.
  - Added the required column `id` to the `Comment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Like` table without a default value. This is not possible if the table is not empty.
  - The required column `id` was added to the `User` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_id_user_fkey";

-- AlterTable
ALTER TABLE "Comment" DROP COLUMN "id_user",
ADD COLUMN     "id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Like" DROP COLUMN "id_user",
ADD COLUMN     "id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "id_user",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
