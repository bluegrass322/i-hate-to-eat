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
}

.date-text {
  margin: 0 20px;
  padding: 0;
}
</style>
