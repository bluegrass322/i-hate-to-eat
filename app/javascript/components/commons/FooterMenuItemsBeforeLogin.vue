<template>
  <v-container class="d-flex align-center ma-0 pa-0">
    <v-btn
      to="/"
      color="accent"
      text
      tile
      :height="height"
      :min-height="minHeight"
      :max-height="maxHeight"
      :min-width="minWidth"
      class="footer-btn ma-0 pb-2 pl-2 flex-grow-1 flex-shrink-0"
    >
      top
    </v-btn>
    <v-btn
      to="/register"
      color="accent"
      text
      tile
      :height="height"
      :min-height="minHeight"
      :max-height="maxHeight"
      :min-width="minWidth"
      class="footer-btn ma-0 pb-2 pl-2 pr-8 flex-grow-1 flex-shrink-0"
    >
      register
    </v-btn>
    <v-btn
      to="/login"
      color="accent"
      text
      tile
      :height="height"
      :min-height="minHeight"
      :max-height="maxHeight"
      :min-width="minWidth"
      class="footer-btn ma-0 pb-2 pl-2 pr-4 flex-grow-1 flex-shrink-0"
    >
      login
    </v-btn>

    <div
      class="
        menu-icon
        d-flex
        justify-center
        align-cneter
        flex-grow-0 flex-shrink-0
        pt-1
      "
    >
      <v-app-bar-nav-icon color="accent" @click.stop="clickNavIcon()" />
    </div>
    <!-- 以下、プルアップメニュー -->
    <!-- xsの場合のみフルスクリーン -->
    <v-dialog
      v-model="listMenuShow"
      :fullscreen="$vuetify.breakpoint.xsOnly"
      :hide-overlay="$vuetify.breakpoint.xsOnly"
      transition="dialog-bottom-transition"
      class="menu-dialog"
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
              @click.stop="closeMenuDialog()"
            >
              <v-list-item-title class="accent--text font-weight-bold text-h6">
                <span class="list-item">{{ item.name }}</span>
                <!-- TODO: noteは調整完了後に削除 -->
                <br /><span style="font-size: 0.3rem">{{ item.note }}</span>
                <!-- TODO: ここまで -->
              </v-list-item-title>
            </v-list-item>
          </template>
          <!-- ここまで -->

          <div class="under-line-spacer mt-14 mb-10" />

          <!-- 文字サイズ小のアイテム -->
          <template v-for="(item, index) in listItemSmall">
            <v-list-item
              :key="`small-${index}`"
              :to="item.to"
              dense
              class="ma-0 pa-0"
              @click.stop="closeMenuDialog()"
            >
              <v-list-item-title
                class="accent--text text-body-2 font-weight-medium"
              >
                <span class="list-item">{{ item.name }}</span>
                <!-- TODO: noteは調整完了後に消す -->
                <br /><span style="font-size: 0.3rem">{{ item.note }}</span>
                <!-- TODO: ここまで -->
              </v-list-item-title>
            </v-list-item>
          </template>
          <!-- ここまで -->
        </v-list-item-group>
      </v-list>
    </v-dialog>
    <!-- ここまで -->
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      maxHeight: 70,
      minHeight: 50,
      minWidth: 50,
      listMenuShow: false,
      listMenuBack: 'rgba(44, 76, 107, 0.8)',
      listItemLarge: [{ name: 'about', to: '/about', note: '(調整中)' }],
      listItemSmall: [
        { name: 'terms of use', note: '(調整中)', to: '/terms' },
        { name: 'privacy policy', note: '(調整中)', to: '/privacy' },
        // { name: 'contact', to: '/' },
      ],
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
  },
  methods: {
    clickNavIcon() {
      this.listMenuShow = !this.listMenuShow;
    },
    closeMenuDialog() {
      this.listMenuShow = false;
    },
  },
};
</script>

<style scoped>
.footer-btn {
  border-right: 1px solid rgba(137, 167, 202, 1);
}

.listmenu-group {
  position: absolute;
  top: 0;
  right: 0;
}

.menu-icon {
  width: 50px;
}

.menu-dialog {
  z-index: 201;
}

.under-line-spacer {
  border-bottom: 1px solid rgb(245, 245, 246);
  width: 15px;
}

.v-btn.footer-btn {
  align-items: flex-end;
  justify-content: flex-start;
  text-transform: none !important;
}
</style>
