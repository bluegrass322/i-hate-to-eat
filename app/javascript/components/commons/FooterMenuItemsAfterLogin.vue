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

    <div class="menu-icon pb-1 flex-grow-0 flex-shrink-0">
      <v-app-bar-nav-icon color="accent" @click.stop="clickNavIcon()" />
    </div>
    <!-- xsの場合のみフルスクリーン -->
    <v-dialog
      v-model="listMenuShow"
      :fullscreen="$vuetify.breakpoint.xsOnly"
      :hide-overlay="$vuetify.breakpoint.xsOnly"
      transition="dialog-bottom-transition"
      style="z-index: 201"
    >
      <v-list
        :color="listMenuBack"
        elevation="0"
        :height="listMenuHeigt"
        :width="listMenuWidth"
        flat
        outlined
        tile
        class="
          listmenu-group
          d-flex
          flex-column
          justify-center
          align-end align-sm-center
          pr-10 pr-sm-5
        "
      >
        <v-list-item-group
          class="d-flex flex-column justify-center align-start"
        >
          <div class="d-flex align-end text-h5 font-weight-black mb-5">
            Menu
          </div>

          <div class="under-line-spacer mt-6 mb-10" />

          <!-- 文字サイズ大のアイテム -->
          <template v-for="(item, index) in listItemLarge">
            <v-list-item
              :key="`large-${index}`"
              :to="item.to"
              dense
              class="mb-6 pa-0"
              @click.stop="clickNavIcon()"
            >
              <!-- TODO: styleは実装完了とともに消す -->
              <v-list-item-title
                class="accent--text font-weight-bold text-h6"
                :style="`${item.style}`"
              >
                <span class="list-item">{{ item.name }}</span>
              </v-list-item-title>
            </v-list-item>
          </template>
          <!-- ログアウトボタンのみ固定配置 -->
          <v-list-item class="ma-0 pa-0" dense>
            <v-list-item-title
              class="accent--text text-h6 font-weight-bold"
              @click="
                clickNavIcon();
                logoutUser();
              "
            >
              <span class="list-item">logout</span>
            </v-list-item-title>
          </v-list-item>
          <!-- ここまで -->

          <div class="under-line-spacer mt-14 mb-10" />

          <!-- 文字サイズ小のアイテム -->
          <template v-for="(item, index) in listItemSmall">
            <v-list-item
              :key="`small-${index}`"
              :to="item.to"
              dense
              class="ma-0 pa-0"
              @click.stop="clickNavIcon()"
            >
              <!-- TODO: styleは実装完了とともに消す -->
              <v-list-item-title
                class="accent--text text-body-2 font-weight-medium"
                :style="`${item.style}`"
              >
                <span class="list-item">{{ item.name }}</span>
              </v-list-item-title>
            </v-list-item>
          </template>
          <!-- ここまで -->
        </v-list-item-group>
      </v-list>
    </v-dialog>
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
      listMenuShow: false,
      listMenuBack: 'rgba(44, 76, 107, 0.8)',
      // TODO: styleは実装完了とともに消す
      listItemLarge: [
        { name: 'mypage', to: '/mypage/setting', style: null },
        { name: 'about', to: '/', style: 'text-decoration: line-through;' },
      ],
      listItemSmall: [
        {
          name: 'terms of use',
          to: '/',
          style: 'text-decoration: line-through;',
        },
        { name: 'contact', to: '/', style: 'text-decoration: line-through;' },
      ],
      // TODO: ここまで
    };
  },
  computed: {
    listMenuHeigt() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return this.$vuetify.breakpoint.height - 50;
        default:
          return this.$vuetify.breakpoint.height - 70;
      }
    },
    listMenuWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return this.$vuetify.breakpoint.width;
        default:
          return 300;
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
        .delete('/api/v1/authentication')
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
    clickNavIcon() {
      this.listMenuShow = !this.listMenuShow;
    },
  },
};
</script>

<style scoped>
.footer-btn {
  /* info */
  border-right: 1px solid rgba(137, 167, 202, 1);
}

.list-item {
  line-height: 1.5rem;
}

.listmenu-group {
  position: absolute;
  top: 0;
  right: 0;
}

.menu-icon {
  text-align: center;
  width: 50px;
}

.under-line-spacer {
  border-bottom: 1px solid rgb(245, 245, 246);
  width: 15px;
}

.v-btn.footer-btn {
  align-items: end;
  justify-content: start;
  text-transform: none !important;
}
</style>