<template>
  <v-container class="d-flex align-center ma-0 pa-0">
    <v-btn
      to="/home"
      color="accent"
      text
      tile
      :height="height"
      :min-height="minHeight"
      :max-height="maxHeight"
      :min-width="minWidth"
      class="footer-btn ma-0 pa-0 pb-2 pl-2 pr-4 flex-grow-1 flex-shrink-0"
    >
      home
    </v-btn>
    <v-btn
      to="/suggestion"
      color="accent"
      text
      tile
      :height="height"
      :min-height="minHeight"
      :max-height="maxHeight"
      :min-width="minWidth"
      class="footer-btn ma-0 pa-0 pb-2 pl-2 pr-8 flex-grow-1 flex-shrink-0"
    >
      today's meal
    </v-btn>
    <v-menu
      transition="scroll-y-reverse-transition"
      :nudge-top="nudgeTop"
      offset-y
      tile
      top
    >
      <template #activator="{ on, attrs }">
        <div class="menu-icon pb-1 flex-grow-0 flex-shrink-0">
          <v-app-bar-nav-icon v-bind="attrs" color="accent" v-on="on" />
        </div>
      </template>

      <v-list :color="menuBack" elevation="0" flat outlined tile>
        <v-list-item-group>
          <v-list-item to="/mypage">
            <v-list-item-title>
              <span class="accent--text text-body-1">マイページ</span>
            </v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title @click="logoutUser">
              <span class="accent--text text-body-1">ログアウト</span>
            </v-list-item-title>
          </v-list-item>
          <v-list-item to="/">
            <v-list-item-title>
              <span class="accent--text text-body-1">サービス概要</span>
            </v-list-item-title>
          </v-list-item>

          <!-- 以下、文字サイズ小のアイテム -->
          <v-list-item to="/" class="small">
            <v-list-item-title>
              <span class="accent--text text-caption">利用規約</span>
            </v-list-item-title>
          </v-list-item>
          <v-list-item to="/" class="small">
            <v-list-item-title>
              <span class="accent--text text-caption">お問い合わせ</span>
            </v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-menu>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      maxHeight: 70,
      minHeight: 50,
      minWidth: 50,
      maxWidth: 150,
      menuBack: 'rgba(90, 120, 153, 0.7)',
    };
  },
  computed: {
    nudgeTop() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 7;
        default:
          return 18;
      }
    },
    height() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 50;
        default:
          return 70;
      }
    },
    widthS() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 50;
        default:
          return 100;
      }
    },
    widthM() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 80;
        default:
          return 140;
      }
    },
    widthL() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 100;
        default:
          return 170;
      }
    },
  },
  methods: {
    logoutUser() {
      this.axios
        .delete('api/v1/authentication')
        .then((response) => {
          console.log(response.status);

          this.$store.commit('authUser/RESET_AUTHUSER_STATE');
          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: 'ログアウトしました',
          });

          this.$router.push({ name: 'TopPage' });
          this.$router.go({
            path: this.$router.currentRoute.path,
            force: true,
          });
        })
        .catch((error) => {
          let e = error.response;
          console.error(e.status);
        });
    },
  },
};
</script>

<style scoped>
.v-btn.footer-btn {
  align-items: end;
  justify-content: start;
  text-transform: none !important;
}

.v-list-item.small {
  min-height: 25px !important;
}

.footer-btn {
  /* info */
  border-right: 3px solid rgba(137, 167, 202, 1.0);
}

.menu-icon {
  text-align: center;
  width: 50px;
}
</style>
