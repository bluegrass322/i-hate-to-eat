import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

dayjs.extend(utc);
dayjs.extend(timezone);

export const getToday = () => {
  const expires = dayjs().tz('Asia/Tokyo').add(2, 'week');
  return expires;
};
