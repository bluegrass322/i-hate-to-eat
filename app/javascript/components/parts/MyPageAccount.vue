<template>
  <div id="account-page">
    <validation-observer ref="observer" v-slot="{ handleSubmit, invalid }">
      <v-form @submit.prevent="handleSubmit(updateAccount)">
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
            color="accent"
            dense
            type="text"
            label="ユーザーネーム"
            outlined
            single-line
            required
            prepend-inner-icon="mdi-account-outline"
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
            prepend-inner-icon="mdi-email-outline"
            required
            single-line
            class="form-item mb-2"
          />
        </validation-provider>
        <div class="line-form-group">
          <div class="line-form-switch d-flex justify-center align-center">
            <v-switch
              v-model="user.line_notification_enabled"
              color="secondary"
              dense
              flat
              hide-details
              inset
              label="LINE通知機能"
              class="switch ma-0"
            ></v-switch>
          </div>
          <div v-show="user.line_notification_enabled" class="py-8 px-7">
            <v-dialog
              ref="dialog"
              v-model="timePicker"
              :return-value.sync="user.mealtime_first"
            >
              <template #activator="{ on, attrs }">
                <v-text-field
                  v-model="user.mealtime_first"
                  label="食事内容を通知する時間"
                  color="accent"
                  dense
                  outlined
                  messages="※ サーバーへの負荷などの要因により通知のタイミングが遅れる場合があります"
                  prepend-inner-icon="mdi-clock-outline"
                  readonly
                  single-line
                  class="form-item"
                  v-bind="attrs"
                  v-on="on"
                ></v-text-field>
                <div class="line-time-desc accent--text text-caption"></div>
              </template>
              <v-time-picker
                v-show="timePicker"
                v-model="user.mealtime_first"
                :allowed-hours="allowedHours"
                :allowed-minutes="allowedMinutes"
                color="secondary"
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
                  clor="accent"
                  class="timepicker-btn left ma-0"
                  @click="timePicker = false"
                >
                  Cancel
                </v-btn>
                <v-btn
                  outlined
                  small
                  tile
                  color="accent"
                  class="timepicker-btn right ma-0"
                  @click="$refs.dialog.save(user.mealtime_first)"
                >
                  OK
                </v-btn>
              </v-time-picker>
            </v-dialog>
            <div class="add-friend mt-6">
              <a href="https://lin.ee/czet3Px">
                <img
                  src="https://scdn.line-apps.com/n/line_add_friends/btn/ja.png"
                  alt="友だち追加"
                  height="36"
                  border="0"
                />
              </a>
            </div>
          </div>
        </div>
        <!-- <div class="primary--text text-caption">
          ※パスワードの変更は、お手数ですがログインページ下部の「パスワードをリセットする」から行ってください
        </div> -->
        <v-btn
          type="submit"
          color="accent"
          :disabled="invalid"
          height="40"
          outlined
          tile
          small
          class="submit-btn mt-10"
        >
          更新
        </v-btn>
      </v-form>
    </validation-observer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: {
        line_notification_enabled: false,
        mealtime_first: null,
      },
      timePicker: false,
      passwordForm: false,
      railsErrors: {
        show: false,
        message: null,
        errorMessages: null,
      },
    };
  },
  mounted() {
    this.setAccount();
  },
  methods: {
    allowedHours: (v) => v >= 7 && v <= 23,
    allowedMinutes: (m) => m % 30 === 0,
    setAccount() {
      this.axios
        .get('/api/v1/user_account')
        .then((res) => {
          console.log(res.status);
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
#account-page {
  text-align: center;
  margin: 0 auto;
  padding: 0;
}

.v-input.form-item,
.line-form-group {
  margin: 0 auto;
}

.line-form-group {
  border: 1px solid rgb(245, 245, 246);
  max-width: 350px;
}

.line-form-switch {
  border-bottom: 1px solid rgb(245, 245, 246);
  height: 40px;
  padding-bottom: 2px;
}

.v-btn.submit-btn {
  width: 100%;
  max-width: 350px;
}

.v-btn.timepicker-btn {
  border-color: rgba(245, 245, 246, 0.2);
  box-sizing: border-box;
  height: 100%;
  width: 50%;
  text-transform: none !important;
}

.v-btn.timepicker-btn.left {
  border-bottom-left-radius: 4px;
}

.v-btn.timepicker-btn.right {
  border-bottom-right-radius: 4px;
}

/* スイッチのラベル */
.v-input--switch >>> .v-label {
  font-size: 0.9rem;
  color: rgb(245, 245, 246);
}

.v-picker >>> .v-card__actions {
  background-color: rgb(90, 120, 153);
  padding: 0 !important;
  width: 100%;
}

.v-text-field {
  max-width: 350px;
  padding: 0 1px 0 0;
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

/* 入力前のプレースホルダー */
/* .v-text-field >>> .v-label {
  color: rgb(245, 245, 246);
} */

/* テキストフィールドの下線 */
/* .v-text-field >>> .v-input__slot::before {
  border-color: rgb(245, 245, 246) !important;
} */
</style>
