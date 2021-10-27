<template>
  <div>
    <div>
      <span class="base--text">
        ユーザー情報（メールアドレス・LINE IDなどの情報を含む）を削除し、サービスの利用を中止します。
      </span>
      <v-btn
        color="base"
        dark
        text
        outlined
        @click.stop="
          setUserName();
          confirmModal = true;
        "
      >
        退会
      </v-btn>
    </div>

    <v-dialog v-model="confirmModal">
      <v-card
        flat
        tile
        color="primary"
        width="120"
        class="foods-card-contents"
      >
        <v-card-text class="pa-0 text-caption text-center base--text">
          <div>{{ user.name }}さん</div>
          <div></div>
        </v-card-text>
        <v-card-actions>
          <v-btn
            color="base"
            dark
            text
            outlined
            small
            @click.stop="closeModal()"
          >
            キャンセル
          </v-btn>
          <v-btn
            color="base"
            dark
            text
            outlined
            small
            @click.stop="
              acceptWithdrawal(user.id);
              closeModal();
            "
          >
            退会する
          </v-btn>
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
        id: '',
        name: '',
      },
      confirmModal: false,
    }
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
        .delete('/api/v1/user_withdrawal', { data: {id: user_id}})
        .then((response) => {
          console.log(response.status);

          this.$store.commit('authUser/RESET_AUTHUSER_STATE');
          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: '退会が完了しました',
          });

          this.$router.push({ name: 'TopPage' });
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
.v-btn {
  width: 120px;
}
</style>