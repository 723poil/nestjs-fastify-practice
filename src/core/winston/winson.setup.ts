import { utilities } from "nest-winston";
import * as winston from "winston";
import "winston-daily-rotate-file";

const dailyOption = (level: string) => {
  let fileLevel: string = level;

  const LOG_DIR: string = process.env.LOG_DIR ?? "logs/";
  const MODE: string = process.env.MODE ?? "local";

  if (level !== "warn" && level !== "debug" && level !== "error") {
    fileLevel = "info";
  }

  return {
    level,
    datePattern: "YYYY-MM-DD",
    dirname: LOG_DIR + fileLevel,
    filename: `%DATE%.${fileLevel}.log`,
    zippedArchive: true,
    format: winston.format.combine(
      winston.format.timestamp({
        format: "YYYY-MM-DD HH:mm:ss",
      }),
      winston.format.ms(),
      utilities.format.nestLike(`PRACTICE-${MODE}`, {
        colors: true,
        prettyPrint: true,
        processId: true,
        appName: true,
      }),
    ),
  };
};

export const transportList = [
  new winston.transports.Console({
    level: !["prod", "production"].includes(process.env.MODE ?? "local") ? "debug" : "info",
    format: winston.format.combine(
      winston.format.timestamp({
        format: "YYYY-MM-DD HH:mm:ss",
      }),
      winston.format.ms(),
      utilities.format.nestLike(`PRACTICE-${process.env.MODE ?? "local"}`, {
        colors: true,
        prettyPrint: true,
        processId: true,
        appName: true,
      }),
    ),
  }),

  new winston.transports.DailyRotateFile(dailyOption("info")),
  new winston.transports.DailyRotateFile(dailyOption("warn")),
  new winston.transports.DailyRotateFile(dailyOption("error")),
];

if (!["prod", "production"].includes(process.env.MODE ?? "local")) {
  transportList.push(new winston.transports.DailyRotateFile(dailyOption("debug")));
}
