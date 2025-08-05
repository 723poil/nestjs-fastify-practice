/*
  Warnings:

  - You are about to drop the `job_roles` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `jobs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `project_members` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `projects` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `task_tag_maps` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `task_tags` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tasks` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."job_roles" DROP CONSTRAINT "job_roles_job_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."project_members" DROP CONSTRAINT "project_members_project_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."project_members" DROP CONSTRAINT "project_members_user_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."task_tag_maps" DROP CONSTRAINT "task_tag_maps_task_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."task_tag_maps" DROP CONSTRAINT "task_tag_maps_task_tag_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."tasks" DROP CONSTRAINT "tasks_member_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."tasks" DROP CONSTRAINT "tasks_project_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."users" DROP CONSTRAINT "users_job_role_id_fkey";

-- DropTable
DROP TABLE "public"."job_roles";

-- DropTable
DROP TABLE "public"."jobs";

-- DropTable
DROP TABLE "public"."project_members";

-- DropTable
DROP TABLE "public"."projects";

-- DropTable
DROP TABLE "public"."task_tag_maps";

-- DropTable
DROP TABLE "public"."task_tags";

-- DropTable
DROP TABLE "public"."tasks";

-- DropTable
DROP TABLE "public"."users";

-- CreateTable
CREATE TABLE "public"."job" (
    "job_id" SERIAL NOT NULL,
    "job_name" TEXT NOT NULL,
    "is_used" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "job_pkey" PRIMARY KEY ("job_id")
);

-- CreateTable
CREATE TABLE "public"."job_role" (
    "job_role_id" SERIAL NOT NULL,
    "job_id" INTEGER NOT NULL,
    "job_role_name" TEXT NOT NULL,
    "is_used" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "job_role_pkey" PRIMARY KEY ("job_role_id")
);

-- CreateTable
CREATE TABLE "public"."project_member" (
    "project_member_id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "member_status" "public"."MemberStatus" NOT NULL DEFAULT 'ACTIVE',
    "member_role" "public"."MemberRole" NOT NULL DEFAULT 'MEMBER',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "project_member_pkey" PRIMARY KEY ("project_member_id")
);

-- CreateTable
CREATE TABLE "public"."project" (
    "project_id" SERIAL NOT NULL,
    "project_name" VARCHAR(100) NOT NULL,
    "project_description" TEXT NOT NULL,
    "project_status" "public"."prjectStatus" NOT NULL DEFAULT 'ACTIVE',
    "start_date" VARCHAR(10) NOT NULL,
    "end_date" VARCHAR(10),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "project_pkey" PRIMARY KEY ("project_id")
);

-- CreateTable
CREATE TABLE "public"."task" (
    "task_id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "member_id" INTEGER NOT NULL,
    "task_name" VARCHAR(30) NOT NULL,
    "task_content" TEXT NOT NULL,
    "duration" DOUBLE PRECISION NOT NULL,
    "task_date" VARCHAR(10) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "task_pkey" PRIMARY KEY ("task_id")
);

-- CreateTable
CREATE TABLE "public"."task_tag" (
    "task_tag_id" SERIAL NOT NULL,
    "task_tag_name" VARCHAR(20) NOT NULL,
    "is_used" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "task_tag_pkey" PRIMARY KEY ("task_tag_id")
);

-- CreateTable
CREATE TABLE "public"."task_tag_map" (
    "task_tag_map_id" SERIAL NOT NULL,
    "task_id" INTEGER NOT NULL,
    "task_tag_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "task_tag_map_pkey" PRIMARY KEY ("task_tag_map_id")
);

-- CreateTable
CREATE TABLE "public"."user" (
    "user_id" SERIAL NOT NULL,
    "user_name" VARCHAR(50),
    "social_type" "public"."SocialType" NOT NULL,
    "social_id" VARCHAR(300) NOT NULL,
    "user_status" "public"."UserStatus" NOT NULL DEFAULT 'REGISTER',
    "job_role_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "user_pkey" PRIMARY KEY ("user_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "job_job_name_key" ON "public"."job"("job_name");

-- CreateIndex
CREATE UNIQUE INDEX "job_role_job_role_name_key" ON "public"."job_role"("job_role_name");

-- CreateIndex
CREATE INDEX "job_role_job_id_job_role_id_idx" ON "public"."job_role"("job_id", "job_role_id");

-- CreateIndex
CREATE INDEX "project_member_project_id_user_id_idx" ON "public"."project_member"("project_id", "user_id");

-- CreateIndex
CREATE INDEX "project_project_name_idx" ON "public"."project"("project_name");

-- CreateIndex
CREATE INDEX "project_created_at_idx" ON "public"."project"("created_at");

-- CreateIndex
CREATE INDEX "project_project_status_idx" ON "public"."project"("project_status");

-- CreateIndex
CREATE INDEX "user_social_type_social_id_idx" ON "public"."user"("social_type", "social_id");

-- CreateIndex
CREATE INDEX "user_user_name_idx" ON "public"."user"("user_name");

-- CreateIndex
CREATE INDEX "user_created_at_idx" ON "public"."user"("created_at");

-- CreateIndex
CREATE INDEX "user_user_status_idx" ON "public"."user"("user_status");

-- AddForeignKey
ALTER TABLE "public"."job_role" ADD CONSTRAINT "job_role_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "public"."job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."project_member" ADD CONSTRAINT "project_member_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."project"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."project_member" ADD CONSTRAINT "project_member_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."task" ADD CONSTRAINT "task_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."project"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."task" ADD CONSTRAINT "task_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "public"."project_member"("project_member_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."task_tag_map" ADD CONSTRAINT "task_tag_map_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "public"."task"("task_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."task_tag_map" ADD CONSTRAINT "task_tag_map_task_tag_id_fkey" FOREIGN KEY ("task_tag_id") REFERENCES "public"."task_tag"("task_tag_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user" ADD CONSTRAINT "user_job_role_id_fkey" FOREIGN KEY ("job_role_id") REFERENCES "public"."job_role"("job_role_id") ON DELETE RESTRICT ON UPDATE CASCADE;
