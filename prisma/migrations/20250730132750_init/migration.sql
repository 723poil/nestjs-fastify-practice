/*
  Warnings:

  - Added the required column `job_id` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."users" ADD COLUMN     "job_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "public"."jobs" (
    "job_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_used" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "jobs_pkey" PRIMARY KEY ("job_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "jobs_name_key" ON "public"."jobs"("name");

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "public"."jobs"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;
