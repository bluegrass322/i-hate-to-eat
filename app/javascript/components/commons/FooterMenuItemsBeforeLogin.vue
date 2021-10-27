<template>
  <div id="menu-items">
    <v-btn
      to="/"
      color="base"
      text
      tile
      min-height="56"
      width="56"
      class="ma-0"
    >
      top
    </v-btn>
    <v-btn
      to="/register"
      color="base"
      text
      tile
      min-height="56"
      width="160"
      class="ma-0"
    >
      register
    </v-btn>
    <v-btn
      to="/login"
      color="base"
      text
      tile
      min-height="56"
      width="100"
      class="ma-0"
    >
      login
    </v-btn>
    <div class="menu-icon">
      <v-app-bar-nav-icon />
    </div>
  </div>
</template>

<script>
export default {};
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
