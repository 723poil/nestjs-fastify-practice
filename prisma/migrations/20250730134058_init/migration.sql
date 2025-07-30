/*
  Warnings:

  - You are about to drop the column `job_id` on the `users` table. All the data in the column will be lost.
  - Added the required column `job_role_id` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."users" DROP CONSTRAINT "users_job_id_fkey";

-- AlterTable
ALTER TABLE "public"."users" DROP COLUMN "job_id",
ADD COLUMN     "job_role_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_job_role_id_fkey" FOREIGN KEY ("job_role_id") REFERENCES "public"."job_roles"("job_role_id") ON DELETE RESTRICT ON UPDATE CASCADE;
