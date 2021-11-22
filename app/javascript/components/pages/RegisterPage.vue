<template>
  <v-row id="register-form" class="d-block mx-16 my-10 pa-0">
    <div class="page-title mb-6">
      <div
        class="
          d-flex
          align-end
          text-subtitle-1 text-sm-h6
          accent--text
          ma-0
          pa-0
          mb-5
        "
      >
        新規ユーザー登録
        <div class="under-line line-right" />
      </div>
    </div>

    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(createUser)">
        <template v-if="railsErrors.show">
          <template v-for="e in railsErrors.errorMessages">
            <v-alert
              :key="e"
              class="text-center text-body-2 text-sm-body-1"
              dense
              type="error"
            >
              {{ e }}
            </v-alert>
          </template>
        </template>

        <validation-provider
          v-slot="{ errors }"
          name="ユーザーネーム"
          rules="required"
        >
          <v-text-field
            v-model="user.name"
            :error-messages="errors"
            color="accent"
            dense
            type="text"
            label="ユーザーネーム"
            outlined
            single-line
            prepend-inner-icon="mdi-account-outline"
            required
            class="form-item mb-2"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="メールアドレス"
          rules="email|required"
        >
          <v-text-field
            v-model="user.email"
            :error-messages="errors"
            color="accent"
            dense
            type="email"
            label="メールアドレス"
            outlined
            single-line
            required
            prepend-inner-icon="mdi-email-outline"
            class="form-item mb-2"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="パスワード"
          rules="alpha_num|min:5|required"
          vid="confirmation"
        >
          <v-text-field
            v-model="user.password"
            :error-messages="errors"
            color="accent"
            dense
            type="password"
            label="パスワード"
            outlined
            single-line
            prepend-inner-icon="mdi-lock-outline"
            required
            class="form-item mb-2"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="パスワード（確認）"
          rules="confirmed:confirmation|required"
        >
          <v-text-field
            v-model="user.password_confirmation"
            :error-messages="errors"
            color="accent"
            dense
            type="password"
            label="パスワード（確認）"
            outlined
            single-line
            prepend-inner-icon="mdi-lock-outline"
            required
            class="form-item"
          />
        </validation-provider>

        <div class="btn-group">
          <v-btn
            type="submit"
            color="accent"
            height="30"
            outlined
            tile
            small
            class="submit-btn mt-5"
            >登録</v-btn
          >
        </div>
      </v-form>
    </validation-observer>
    <div class="captions mt-12 px-1">
      <div class="mb-4 d-flex flex-column align-center">
        <router-link
          to="/terms"
          class="text-body-2 accent--text mb-2"
        >
          利用規約
        </router-link>
        <router-link
          to="/privacy"
          class="text-body-2 accent--text"
        >
          プライバシーポリシー
        </router-link>
      </div>
      <p class="caption-indented text-caption accent--text">
        ※ 登録ボタンをクリックし登録処理が確定した時点で、利用規約及びプライバシーポリシーを確認の上同意したものとみなします。
      </p>
    </div>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: '',
        email: '',
        gender: '',
        birth: '',
        password: '',
        password_confirmation: '',
      },
      birthInput: false,
      railsErrors: {
        show: false,
        message: '',
        errorMessages: [],
      },
    };
  },
  methods: {
    createUser() {
      this.axios
        .post('api/v1/registration', { user: this.user })
        .then((res) => {
          console.log(res.status);

          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: '登録に成功しました',
          });

          // TODO: 遷移先を一時的にTopに、後に修正
          this.$router.push({ name: 'TopPage' });
        })
        .catch((error) => {
          let e = error.response;
          console.error(e.status);

          if (e.data.errors) {
            this.railsErrors.errorMessages = e.data.errors;
          }
          if (this.railsErrors.errorMessages.length != 0) {
            this.railsErrors.show = true;
            setTimeout(() => {
              this.railsErrors.show = false;
            }, 5000);
          }
        });
    },
  },
};
</script>

<style scoped>
.under-line {
  border-bottom: 1px solid rgb(245, 245, 246);
  position: relative;
  top: -6px;
}

.under-line.line-right {
  margin-left: 5px;
  width: 13px;
}

.page-title,
.v-text-field,
.btn-group,
.v-btn.submit-btn {
  max-width: 350px;
  padding: 0;
}

.page-title,
.v-input.form-item {
  margin: 0 auto;
}

.btn-group {
  margin: 0 auto;
  width: 100%;
}

.v-btn.submit-btn {
  width: 100%;
}

/* アイコン・入力値含むテキストフィールド */
.v-text-field.form-item >>> .v-input__slot {
  padding: 0 10px 0 0 !important;
  color: rgba(90, 120, 153, 1) !important;
}

/* prepend-inner-icon */
.v-text-field.form-item >>> .v-input__prepend-inner {
  background-color: rgba(44, 76, 107);
  margin: 0 15px 0 0 !important;
  padding: 7px;
}

/* outlinedの場合 */
.v-text-field.form-item >>> .v-input__slot {
  border-radius: 0;
  border: 1px solid rgb(245, 245, 246);
}

.captions {
  margin: 0 auto;
  max-width: 350px;
}

.caption-indented {
  /* 2行目以降を1字下げ */
  padding-left: 1rem;
  text-indent: -1rem;
}
</style>
