import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

export const getToday = () => {
  dayjs.extend(utc);
  dayjs.extend(timezone);

  const expires = dayjs().tz('Asia/Tokyo').add(2, 'week');
  return expires;
};