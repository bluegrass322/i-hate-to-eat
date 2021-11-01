<template>
  <v-container class="container">
    <div class="date">
      <p class="date-text text-h5 primary--text">
        {{ date }}
      </p>
    </div>
    <div>
      <p>ログイン状況</p>
      <p>ユーザーID: {{ userId }}</p>
      <p>ログイン: {{ isLoggedIn }}</p>
    </div>
    <div>
      <span>{{ mealRecords }}</span>
    </div>
  </v-container>
</template>

<script>
import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';
import { mapState } from 'vuex';

export default {
  data() {
    return {
      date: '',
      mealRecords: '',
    };
  },
  computed: {
    ...mapState({
      userId: (state) => state.authUser.userId,
      isLoggedIn: (state) => state.authUser.isLoggedIn,
    }),
  },
  mounted() {
    this.setDate();
    this.setMealRecords();
  },
  methods: {
    setMealRecords() {
      this.axios
        .get('/api/v1/home')
        .then((res) => {
          console.log(res.status);
          console.log(res);
          this.mealRecords = res.data.records;
        })
        .catch((e) => {
          console.log(e.response.status);
        });
    },
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
}

.date-text {
  margin: 0 20px;
  padding: 0;
}
</style>
