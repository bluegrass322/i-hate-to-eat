<template>
  <div id="mypage" class="ma-0 pa-0">
    <v-row class="header-btns">
      <v-col cols="12" class="d-flex justify-center">
        <v-btn
          to="/mypage/setting"
          color="accent"
          text
          tile
          :height="btnHeight"
          :width="btnWidth"
          class="footer-btn ma-0 px-2 flex-grow-1 text-caption text-sm-suubtitle-1"
        >
          栄養摂取基準設定
        </v-btn>
        <v-btn
          to="/mypage/account"
          color="accent"
          text
          tile
          :height="btnHeight"
          :width="btnWidth"
          class="footer-btn ma-0 px-2 flex-grow-1 text-caption text-sm-suubtitle-1"
        >
          アカウント設定
        </v-btn>
        <v-btn
          to="/mypage/withdrawal"
          color="accent"
          text
          tile
          :height="btnHeight"
          :width="btnWidthS"
          class="footer-btn ma-0 px-2 flex-grow-1 text-caption text-sm-suubtitle-1"
        >
          退会
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
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

.v-btn.footer-btn {
  align-items: center;
  justify-content: center;
}

.v-list-item.small {
  min-height: 25px !important;
}

.footer-btn {
  /* info */
  border-right: 3px solid rgba(137, 167, 202, 1);
}
</style>
