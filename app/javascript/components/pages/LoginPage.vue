<template>
  <v-row id="login-form" class="d-block mx-16 mb-10 pa-0">
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
      <v-form @submit.prevent="handleSubmit(loginUser)">
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
            v-model="name"
            :error-messages="errors"
            color="accent"
            dense
            type="text"
            label="ユーザーネーム"
            outlined
            single-line
            prepend-inner-icon="mdi-account-outline"
            required
            class="form-item mb-1"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="パスワード"
          rules="alpha_num|min:7|required"
          vid="confirmation"
        >
          <v-text-field
            v-model="password"
            :error-messages="errors"
            color="accent"
            dense
            type="password"
            label="パスワード"
            outlined
            single-line
            prepend-inner-icon="mdi-lock-outline"
            required
            class="form-item mb-1"
          />
        </validation-provider>
        <v-btn
          type="submit"
          color="accent"
          height="30"
          tile
          outlined
          small
          class="submit-btn mt-5"
          >ログイン</v-btn
        >
      </v-form>
    </validation-observer>
  </v-row>
</template>

<script>
import { getToday } from '../../plugins/get-timezone-today';

export default {
  data() {
    return {
      name: null,
      password: null,
      railsErrors: {
        show: false,
        message: null,
        errorMessages: null,
      },
    };
  },
  methods: {
    loginUser() {
      this.axios
        .post('api/v1/authentication', {
          name: this.name,
          password: this.password,
        })
        .then((response) => {
          console.log(response.status);

          const expires = getToday();
          this.$store.commit('authUser/login', {
            userId: response.data,
            expires: expires,
          });
          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: 'ログインしました',
          });

          this.$router.push({ name: 'MealSuggestionPage' });
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
#login-form {
  text-align: center;
}

.page-title,
.v-text-field,
.v-btn.submit-btn {
  max-width: 350px;
  padding: 0;
}

.page-title,
.v-input.form-item {
  margin: 0 auto;
}

.under-line {
  border-bottom: 1px solid rgb(245, 245, 246);
  position: relative;
    top: -6px;
}

.under-line.line-right {
  margin-left: 5px;
  width: 13px;
}

.v-btn.submit-btn {
  width: 100%;
}

.v-input.form-item {
  margin: 0 auto;
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
</style>
