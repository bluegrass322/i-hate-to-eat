export const formatDate = (value) => {
  const y = value.getFullYear();
  const m = ('00' + (value.getMonth() + 1)).slice(-2);
  const d = ('00' + value.getDate()).slice(-2);
  return y + m + d;
};

export const calcAge = (value) => {
  const today = new Date();
  const formated_today = formatDate(today);
  const birth = value.replace(/-/g, '');
  return Math.floor((parseInt(formated_today) - parseInt(birth)) / 10000);
};
