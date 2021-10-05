<template>
  <div id="menu-items">
    <v-btn
      to="/home"
      color="base"
      text
      tile
      min-height="56"
      width="56"
      class="ma-0"
    >
      home
    </v-btn>
    <v-btn
      color="base"
      text
      tile
      min-height="56"
      width="100"
      class="ma-0"
      @click="logoutUser"
    >
      logout
    </v-btn>
    <v-menu offset-y tile top>
      <template #activator="{ on, attrs }">
        <div class="menu-icon">
          <v-app-bar-nav-icon v-bind="attrs" v-on="on" />
        </div>
      </template>

      <v-list :color="menuBack" flat min-width="150px" outlined tile>
        <v-list-item-group color="base">
          <v-list-item to="/mypage">
            <v-list-item-title>mypage</v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-menu>
  </div>
</template>

<script>
export default {
  data() {
    return {
      menuBack: 'rgba(72, 96, 122, 0.7)',
    };
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
* {
  text-transform: none !important;
}

#menu-items {
  display: flex;
  margin: 0;
  padding: 0;
}

.menu-icon {
  height: 56px;
  text-align: center;
  width: 56px;
}
</style>
