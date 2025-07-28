-- CreateEnum
CREATE TYPE "PrjectStatus" AS ENUM ('ACTIVE', 'STOP', 'FINISHED', 'DELETED');

-- CreateEnum
CREATE TYPE "SocialType" AS ENUM ('KAKAO', 'APPLE', 'GOOGLE');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('REGISTER', 'ACTIVE', 'WITHDRAW', 'DELETED');

-- CreateTable
CREATE TABLE "Projects" (
    "project_id" SERIAL NOT NULL,
    "project_name" VARCHAR(100) NOT NULL,
    "project_status" "PrjectStatus" NOT NULL DEFAULT 'ACTIVE',
    "start_date" VARCHAR(10) NOT NULL,
    "end_date" VARCHAR(10),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Projects_pkey" PRIMARY KEY ("project_id")
);

-- CreateTable
CREATE TABLE "Users" (
    "user_id" SERIAL NOT NULL,
    "user_name" VARCHAR(50),
    "social_type" "SocialType" NOT NULL,
    "social_id" VARCHAR(300) NOT NULL,
    "user_status" "UserStatus" NOT NULL DEFAULT 'REGISTER',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("user_id")
);

-- CreateIndex
CREATE INDEX "Projects_project_name_idx" ON "Projects"("project_name");

-- CreateIndex
CREATE INDEX "Projects_created_at_idx" ON "Projects"("created_at");

-- CreateIndex
CREATE INDEX "Projects_project_status_idx" ON "Projects"("project_status");

-- CreateIndex
CREATE INDEX "Users_social_type_social_id_idx" ON "Users"("social_type", "social_id");

-- CreateIndex
CREATE INDEX "Users_user_name_idx" ON "Users"("user_name");

-- CreateIndex
CREATE INDEX "Users_created_at_idx" ON "Users"("created_at");

-- CreateIndex
CREATE INDEX "Users_user_status_idx" ON "Users"("user_status");
