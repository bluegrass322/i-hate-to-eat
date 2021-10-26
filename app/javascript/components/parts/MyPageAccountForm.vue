<template>
    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(updateAccount)" id="account-form">
        <template v-if="railsErrors.show">
          <v-alert class="text-center" dense type="error">
            <template v-for="e in railsErrors.errorMessages">
              <p :key="e">{{ e }}</p>
            </template>
          </v-alert>
        </template>

        <validation-provider
          v-slot="{ errors }"
          name="ユーザーネーム"
          rules="required"
        >
          <v-text-field
            v-model="user.name"
            :error-messages="errors"
            color="base"
            dark
            dense
            type="text"
            label="ユーザーネーム"
            prepend-icon="mdi-account-outline"
            required
            class="form-item"
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
            color="base"
            dark
            dense
            type="email"
            label="メールアドレス"
            prepend-icon="mdi-email-outline"
            required
            class="form-item"
          />
        </validation-provider>
        <div class="form-item line-form">
          <div class="line-form-switch">
            <v-switch
              v-model="user.line_notification_enabled"
              color="base"
              dark
              dense
              flat
              inset
              label="LINE通知機能"
            ></v-switch>
          </div>
          <div v-show="user.line_notification_enabled">
            <v-dialog
              ref="dialog"
              v-model="timePicker"
              :return-value.sync="user.mealtime_first"
            >
              <template #activator="{ on, attrs }">
                <v-text-field
                  v-model="user.mealtime_first"
                  label="食事内容を通知する時間"
                  color="base"
                  dark
                  dense
                  prepend-icon="mdi-clock-time-four-outline"
                  readonly
                  v-bind="attrs"
                  v-on="on"
                ></v-text-field>
              </template>
              <v-time-picker
                v-show="timePicker"
                v-model="user.mealtime_first"
                :allowed-hours="allowedHours"
                :allowed-minutes="allowedMinutes"
                color="primary"
                flat
                format="24hr"
                min="7:00"
                max="23:00"
                scrollable
                full-width
              >
                <v-btn
                  outlined
                  small
                  tile
                  clor="primary"
                  @click="timePicker = false"
                >
                  Cancel
                </v-btn>
                <v-btn
                  outlined
                  small
                  tile
                  color="primary"
                  @click="$refs.dialog.save(user.mealtime_first)"
                >
                  OK
                </v-btn>
              </v-time-picker>
            </v-dialog>
            <div class="base--text text-caption">
              ※サーバーへの負荷などの要因により通知のタイミングが数分ほど遅れる場合があります
            </div>
            <div>
              <a href="https://lin.ee/czet3Px">
                <img src="https://scdn.line-apps.com/n/line_add_friends/btn/ja.png" alt="友だち追加" height="36" border="0">
              </a>
            </div>
          </div>
        </div>
        <div class="base--text text-caption">
          ※パスワードの変更は、お手数ですがログインページ下部の「パスワードをリセットする」から行ってください
        </div>
        <v-btn type="submit" color="base" outlined tile small width="120">更新</v-btn>
    </v-form>
  </validation-observer>
</template>

<script>
export default {
  data() {
    return {
      user: {
        line_notification_enabled: false,
        mealtime_first: '',
      },
      timePicker: false,
      passwordForm: false,
      railsErrors: {
        show: false,
        message: '',
        errorMessages: [],
      },
    };
  },
  mounted() {
    this.setAccount();
  },
  methods: {
    setAccount() {
      this.axios
        .get('/api/v1/user_account')
        .then((res) => {
          console.log(res.status);
          console.log(res.data);

          this.user = res.data;
        })
        .catch((e) => {
          console.log(e.response.status);
        });
    },
    updateAccount() {
      this.axios
        .patch('/api/v1/user_account', { user: this.user })
        .then((res) => {
          console.log(res.status);

          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: '更新に成功しました',
          });
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
    allowedHours: (v) => v >= 7 && v <= 23,
    allowedMinutes: (m) => m % 30 === 0,
  },
};
</script>

<style scoped>
#account-form {
  text-align: center;
}
.form-item {
  margin-bottom: 30px;
  margin-left: auto;
  margin-right: auto;
}

.line-form-switch {
  margin-bottom: 20px;
}

.v-text-field {
  max-width: 350px;
}
</style>