<template>
  <v-container class="container">
    <div class="date">
      <p class="date-text text-h5 primary--text">
        {{ date }}
      </p>
    </div>
  </v-container>
</template>

<script>
import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

export default {
  data() {
    return {
      date: '',
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

<style scoped>
.container {
  margin: 10px, 0;
  padding: 0;
}

.date {
  margin-top: 20px;
  height: 30;
  border-bottom: medium solid #5a7899;
  /* エリア確認用 */
  /* background-color: rgba(90, 40, 80, 0.3); */
}

.date-text {
  margin: 0 20px;
  padding: 0;
}
</style>
