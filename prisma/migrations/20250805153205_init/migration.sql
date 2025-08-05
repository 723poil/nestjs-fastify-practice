/*
  Warnings:

  - Added the required column `project_description` to the `projects` table without a default value. This is not possible if the table is not empty.
  - Added the required column `task_date` to the `tasks` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "public"."MemberStatus" AS ENUM ('ACTIVE', 'BAN');

-- CreateEnum
CREATE TYPE "public"."MemberRole" AS ENUM ('OWNER', 'MEMBER');

-- AlterTable
ALTER TABLE "public"."project_members" ADD COLUMN     "member_role" "public"."MemberRole" NOT NULL DEFAULT 'MEMBER',
ADD COLUMN     "member_status" "public"."MemberStatus" NOT NULL DEFAULT 'ACTIVE';

-- AlterTable
ALTER TABLE "public"."projects" ADD COLUMN     "project_description" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."tasks" ADD COLUMN     "task_date" VARCHAR(10) NOT NULL;
