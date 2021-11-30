import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

export const checkAuthUserExpires = (expires) => {
  dayjs.extend(utc);
  dayjs.extend(timezone);

  const today = dayjs().tz('Asia/Tokyo');
  const expiresAt = dayjs(expires).tz('Asia/Tokyo');

  return today > expiresAt;
};
