<template>
  <div
    id="withdrawal-page"
    class="d-flex flex-column align-center ma-0 mt-5 pa-0"
  >
    <div
      class="desc-text accent--text text-body-2 text-sm-body-1 ma-0 ml-7 pa-0"
    >
      <div class="text-item d-flex align-end ma-0 mb-4 mb-sm-6 pa-0">
        退会する
        <div class="under-line line-title" />
      </div>
      <div class="text-item ma-0 mb-4 mb-sm-6 pa-0">
        メールアドレス・LINE
        IDなどのすべてのユーザー情報を削除し、サービスの利用を中止します。
      </div>
      <div class="text-item ma-0 mb-8 mb-sm-10 pa-0">
        なお、過去の記録の復元は不可能となりますので、あらかじめご了承ください。
      </div>
      <div class="under-line-spacer" />
    </div>

    <v-dialog v-model="confirmModal" max-width="350">
      <template #activator="{ on, attrs }">
        <v-btn
          color="accent"
          height="30"
          outlined
          tile
          class="withdrawal-btn mt-12"
          v-bind="attrs"
          v-on="on"
          @click.stop="setUserName()"
        >
          退会
        </v-btn>
      </template>

      <v-card flat tile color="primary" class="py-5 px-8">
        <v-card-text
          class="d-flex justify-center text-body-2 accent--text pa-0"
        >
          <div class="dialog-text-items mb-3">
            <div class="d-flex mb-3">
              {{ user.name }}さん
              <div class="under-line dialog-text-item" />
            </div>
            <p class="mt-3 mb-0">退会処理を確定します</p>
            <p>よろしいですか？</p>
          </div>
        </v-card-text>
        <v-card-actions class="dialog-btn-group pa-0">
          <div class="dialog-btn-items">
            <v-btn
              color="accent"
              outlined
              small
              tile
              class="dialog-btn ma-0 mr-3"
              @click.stop="closeModal()"
            >
              Cancel
            </v-btn>
            <v-btn
              color="accent"
              outlined
              small
              tile
              class="dialog-btn ma-0"
              @click.stop="
                acceptWithdrawal(user.id);
                closeModal();
              "
            >
              OK
            </v-btn>
          </div>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: {
        id: null,
        name: null,
      },
      confirmModal: false,
      dialogBtnWidth: '30%',
    };
  },
  mounted() {
    this.setUserName();
  },
  methods: {
    setUserName() {
      this.axios
        .get('/api/v1/user_withdrawal')
        .then((res) => {
          console.log(res.status);
          this.user = res.data;
        })
        .catch((e) => {
          console.error(e.response.status);
        });
    },
    acceptWithdrawal(user_id) {
      this.axios
        .delete('/api/v1/user_withdrawal', { data: { id: user_id } })
        .then((response) => {
          console.log(response.status);

          this.$store.commit('authUser/RESET_AUTHUSER_STATE');
          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: '退会が完了しました',
          });

          this.$router.push({ name: 'TopPage' });
          this.$router.go({
            path: this.$router.currentRoute.path,
            force: true,
          });
        })
        .catch((e) => {
          console.error(e.response.status);
        });
    },
    closeModal() {
      this.confirmModal = false;
    },
  },
};
</script>

<style scoped>
#withdrawal-page {
  text-align: center;
}

.confirm-text-group {
  width: 100%;
}

.desc-text {
  position: relative;
  top: 0;
  left: 0;
}

.dialog-btn-items {
  text-align: center;
  margin: 0 auto;
  width: 100%;
}

.dialog-text-items {
  text-align: start;
}

.under-line {
  border-bottom: 1px solid rgb(245, 245, 246);
  margin-left: 5px;
  position: relative;
  top: -5px;
  left: -1px;
}

.under-line-spacer {
  border-bottom: 1px solid rgb(245, 245, 246);
  width: 15px;
}

.under-line.dialog-text-item {
  width: 10px;
}

.line-title {
  width: 35px;
}

.text-item {
  text-align: start;
  width: 90%;
  max-width: 350px;
}

.v-btn.dialog-btn {
  text-transform: none !important;
  width: 30%;
}

.v-btn.withdrawal-btn {
  /* border-top: none;
  border-right: none;
  border-left: none; */
  width: 80%;
  max-width: 330px;
}
</style>
