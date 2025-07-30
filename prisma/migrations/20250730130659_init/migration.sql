/*
  Warnings:

  - You are about to drop the `Projects` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Users` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "public"."prjectStatus" AS ENUM ('ACTIVE', 'STOP', 'FINISHED', 'DELETED');

-- DropTable
DROP TABLE "public"."Projects";

-- DropTable
DROP TABLE "public"."Users";

-- DropEnum
DROP TYPE "public"."PrjectStatus";

-- CreateTable
CREATE TABLE "public"."projects" (
    "project_id" SERIAL NOT NULL,
    "project_name" VARCHAR(100) NOT NULL,
    "project_status" "public"."prjectStatus" NOT NULL DEFAULT 'ACTIVE',
    "start_date" VARCHAR(10) NOT NULL,
    "end_date" VARCHAR(10),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "projects_pkey" PRIMARY KEY ("project_id")
);

-- CreateTable
CREATE TABLE "public"."project_members" (
    "project_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "project_members_pkey" PRIMARY KEY ("project_id","user_id")
);

-- CreateTable
CREATE TABLE "public"."users" (
    "user_id" SERIAL NOT NULL,
    "user_name" VARCHAR(50),
    "social_type" "public"."SocialType" NOT NULL,
    "social_id" VARCHAR(300) NOT NULL,
    "user_status" "public"."UserStatus" NOT NULL DEFAULT 'REGISTER',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateIndex
CREATE INDEX "projects_project_name_idx" ON "public"."projects"("project_name");

-- CreateIndex
CREATE INDEX "projects_created_at_idx" ON "public"."projects"("created_at");

-- CreateIndex
CREATE INDEX "projects_project_status_idx" ON "public"."projects"("project_status");

-- CreateIndex
CREATE INDEX "users_social_type_social_id_idx" ON "public"."users"("social_type", "social_id");

-- CreateIndex
CREATE INDEX "users_user_name_idx" ON "public"."users"("user_name");

-- CreateIndex
CREATE INDEX "users_created_at_idx" ON "public"."users"("created_at");

-- CreateIndex
CREATE INDEX "users_user_status_idx" ON "public"."users"("user_status");

-- AddForeignKey
ALTER TABLE "public"."project_members" ADD CONSTRAINT "project_members_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."project_members" ADD CONSTRAINT "project_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;
