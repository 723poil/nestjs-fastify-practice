-- CreateTable
CREATE TABLE "public"."tasks" (
    "task_id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "member_id" INTEGER NOT NULL,

    CONSTRAINT "tasks_pkey" PRIMARY KEY ("task_id")
);

-- AddForeignKey
ALTER TABLE "public"."tasks" ADD CONSTRAINT "tasks_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."tasks" ADD CONSTRAINT "tasks_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "public"."project_members"("project_member_id") ON DELETE RESTRICT ON UPDATE CASCADE;
