import dayjs from "dayjs";

export const getDateTimeForDb = () => {
  return dayjs().tz().add(9, "hour").format("YYYY-MM-DDTHH:mm:ssZ");
};
