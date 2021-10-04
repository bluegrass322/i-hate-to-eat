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
    <div class="menu-icon">
      <v-app-bar-nav-icon />
    </div>
  </div>
</template>

<script>
export default {
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
