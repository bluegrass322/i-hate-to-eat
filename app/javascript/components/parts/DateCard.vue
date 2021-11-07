<template>
  <v-row>
    <v-col cols="12" class="d-block date pa-0 pl-8">
      <span class="text-h5 accent--text pa-0">
        {{ date }}
      </span>
    </v-col>
  </v-row>
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

<style scoped>
.date {
  border-bottom: 1px solid #f5f5f6;
}
</style>
