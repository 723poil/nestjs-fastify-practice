/*
  Warnings:

  - The primary key for the `job_roles` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `project_members` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
CREATE SEQUENCE "public".job_roles_job_role_id_seq;
ALTER TABLE "public"."job_roles" DROP CONSTRAINT "job_roles_pkey",
ALTER COLUMN "job_role_id" SET DEFAULT nextval('"public".job_roles_job_role_id_seq'),
ADD CONSTRAINT "job_roles_pkey" PRIMARY KEY ("job_role_id");
ALTER SEQUENCE "public".job_roles_job_role_id_seq OWNED BY "public"."job_roles"."job_role_id";

-- AlterTable
ALTER TABLE "public"."project_members" DROP CONSTRAINT "project_members_pkey",
ADD COLUMN     "project_member_id" SERIAL NOT NULL,
ADD CONSTRAINT "project_members_pkey" PRIMARY KEY ("project_member_id");

-- CreateIndex
CREATE INDEX "job_roles_job_id_job_role_id_idx" ON "public"."job_roles"("job_id", "job_role_id");

-- CreateIndex
CREATE INDEX "project_members_project_id_user_id_idx" ON "public"."project_members"("project_id", "user_id");
