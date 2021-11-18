<template>
  <div class="accent--text ma-0 pa-0">
    {{ date }}
  </div>
</template>

<script>
import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

export default {
  data() {
    return {
      date: null,
    };
  },
  mounted() {
    this.setDate();
  },
  methods: {
    setDate() {
      dayjs.extend(utc);
      dayjs.extend(timezone);

      const today = dayjs();
      this.date = today.tz('Asia/Tokyo').format('YYYY.MM.DD');
    },
  },
};
</script>
