/*
  Warnings:

  - You are about to drop the column `name` on the `jobs` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[job_name]` on the table `jobs` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `job_name` to the `jobs` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "public"."jobs_name_key";

-- AlterTable
ALTER TABLE "public"."jobs" DROP COLUMN "name",
ADD COLUMN     "job_name" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "public"."job_roles" (
    "job_id" INTEGER NOT NULL,
    "job_role_id" INTEGER NOT NULL,
    "job_role_name" TEXT NOT NULL,
    "is_used" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "job_roles_pkey" PRIMARY KEY ("job_id","job_role_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "job_roles_job_role_name_key" ON "public"."job_roles"("job_role_name");

-- CreateIndex
CREATE UNIQUE INDEX "jobs_job_name_key" ON "public"."jobs"("job_name");

-- AddForeignKey
ALTER TABLE "public"."job_roles" ADD CONSTRAINT "job_roles_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "public"."jobs"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;
