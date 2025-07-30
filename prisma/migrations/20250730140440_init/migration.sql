/*
  Warnings:

  - Added the required column `duration` to the `tasks` table without a default value. This is not possible if the table is not empty.
  - Added the required column `task_content` to the `tasks` table without a default value. This is not possible if the table is not empty.
  - Added the required column `task_name` to the `tasks` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."tasks" ADD COLUMN     "duration" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "task_content" TEXT NOT NULL,
ADD COLUMN     "task_name" VARCHAR(30) NOT NULL;

-- CreateTable
CREATE TABLE "public"."task_tags" (
    "task_tag_id" SERIAL NOT NULL,
    "task_tag_name" VARCHAR(20) NOT NULL,
    "is_used" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "task_tags_pkey" PRIMARY KEY ("task_tag_id")
);

-- CreateTable
CREATE TABLE "public"."task_tag_maps" (
    "task_tag_maps_id" SERIAL NOT NULL,
    "task_id" INTEGER NOT NULL,
    "task_tag_id" INTEGER NOT NULL,

    CONSTRAINT "task_tag_maps_pkey" PRIMARY KEY ("task_tag_maps_id")
);

-- AddForeignKey
ALTER TABLE "public"."task_tag_maps" ADD CONSTRAINT "task_tag_maps_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("task_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."task_tag_maps" ADD CONSTRAINT "task_tag_maps_task_tag_id_fkey" FOREIGN KEY ("task_tag_id") REFERENCES "public"."task_tags"("task_tag_id") ON DELETE RESTRICT ON UPDATE CASCADE;
