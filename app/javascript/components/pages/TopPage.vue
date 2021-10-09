<template>
  <v-container class="container">
    <div class="date">
      <p class="date-text text-h5 primary--text">
        {{ date }}
      </p>
    </div>
    <router-view />
    <!-- TODO: アクセス制限確認用 -->
    <div>
      <p>実装済みリスト</p>
      <p>食品カテゴリー・食品</p>
      <p>rakeタスクを作成</p>
      <p>require login</p>
      <router-link to="/home">home</router-link>
      <router-link to="/mypage">mypage（コントローラー改修済）</router-link>
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
}

.date-text {
  margin: 0 20px;
  padding: 0;
}
</style>
