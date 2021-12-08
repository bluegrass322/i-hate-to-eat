<template>
  <v-row id="register-form" class="d-block mx-16 my-10 pa-0">
    <div class="page-title mb-6">
      <div
        class="
          d-flex
          align-end
          text-subtitle-1 text-sm-h6
          accent--text
          mb-5
          pa-0
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
          rules="alpha_num|min:7|required"
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
    <div class="captions mt-12 px-1 d-flex flex-column align-center">
      <div class="mb-4 d-flex flex-column flex-sm-row align-center">
        <router-link to="/terms" class="text-body-2 accent--text mb-2 mb-sm-0">
          利用規約
        </router-link>
        <router-link
          to="/privacy"
          class="text-body-2 accent--text ml-0 ml-sm-5"
        >
          プライバシーポリシー
        </router-link>
      </div>
      <div class="caption-indented text-caption accent--text">
        ※
        登録ボタンをクリックし登録処理が確定した時点で、利用規約及びプライバシーポリシーを確認の上同意したものとみなします。
      </div>
    </div>
  </v-row>
</template>

<script>
import { getToday } from '../../plugins/get-timezone-today';

export default {
  data() {
    return {
      user: {
        name: null,
        email: null,
        gender: null,
        birth: null,
        password: null,
        password_confirmation: null,
      },
      birthInput: false,
      railsErrors: {
        show: false,
        message: null,
        errorMessages: null,
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
            message: '登録成功、引き続き設定を行ってみましょう',
            timeout: 1000 * 5,
          });

          // オートログイン
          const expires = getToday();
          this.$store.commit('authUser/login', {
            userId: res.data,
            expires: expires,
          });

          this.$router.push({ name: 'MyPageSetting' });
        })
        .catch((error) => {
          console.error(error.response.status);

          let e = error.response.data.errors;
          if (e && e.length != 0) {
            this.railsErrors.errorMessages = e;
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
  color: rgba(90, 120, 153, 1) !important;
  padding: 0 10px 0 0 !important;
}

/* prepend-inner-icon */
.v-text-field.form-item >>> .v-input__prepend-inner {
  background-color: rgba(44, 76, 107);
  margin: 0 15px 0 0 !important;
  padding: 7px;
}

/* outlinedの場合 */
.v-text-field.form-item >>> .v-input__slot {
  border: 1px solid rgb(245, 245, 246);
  border-radius: 0;
}

.captions {
  margin: 0 auto;
  max-width: 500px;
}

.caption-indented {
  /* 2行目以降を1字下げ */
  padding-left: 1rem;
  text-indent: -1rem;
}
</style>
