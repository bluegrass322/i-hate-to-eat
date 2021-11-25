<template>
  <div id="mypage" class="ma-0 pa-0">
    <v-row class="top-row mt-6 mb-5">
      <v-col cols="12" class="ma-0 pa-0">
        <div class="top-links d-flex flex-column align-end">
          <router-link
            to="/mypage/setting"
            class="link-item d-flex align-end text-body-2 accent--text mb-3"
          >
            栄養摂取基準設定
            <div class="under-line line-first" />
          </router-link>
          <router-link
            to="/mypage/account"
            class="link-item d-flex align-end text-body-2 accent--text mb-2"
          >
            アカウント設定
            <div class="under-line line-second" />
          </router-link>
          <router-link
            to="/mypage/withdrawal"
            class="link-item d-flex align-end text-body-2 accent--text"
          >
            退会
            <div class="under-line line-third" />
          </router-link>
        </div>
      </v-col>
    </v-row>

    <v-row>
      <v-col class="mypage-content px-6 py-0">
        <router-view />
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  data() {
    return {
      btnHeight: '60',
      btnWidth: '38%',
      btnWidthS: '24%',
    };
  },
};
</script>

<style scoped>
#mypage {
  width: 100%;
}

.link-item {
  text-decoration: none;
}

.under-line {
  border-bottom: 1px solid rgb(245, 245, 246);
  margin-left: 5px;
  position: relative;
  top: -6px;
}

.line-first {
  width: 90px;
}

.line-second {
  width: 50px;
}

.line-third {
  width: 210px;
}

.top-row {
  position: fixed;
  top: 0%;
  right: 0;
  z-index: 999;
}

.mypage-content {
  margin: 120px 36px 64px 36px;
}
</style>
