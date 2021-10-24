<template>
  <v-card id="account-form" color="primary" flat tile>
    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(updateAccount)">
        <v-card-text>
          <template v-if="railsErrors.show">
            <v-alert class="text-center" dense type="error">
              <template v-for="e in railsErrors.errorMessages">
                <p :key="e">{{ e }}</p>
              </template>
            </v-alert>
          </template>

          <v-switch
            v-model="user.line_notification_enabled"
            color="base"
            dark
            dense
            flat
            label="LINE通知機能"
          ></v-switch>
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
                  prepend-icon="mdi-clock-time-four-outline"
                  color="base"
                  dark
                  readonly
                  v-bind="attrs"
                  v-on="on"
                ></v-text-field>
              </template>
              <v-time-picker
                v-if="timePicker"
                v-model="user.mealtime_first"
                :allowed-hours="allowedHours"
                :allowed-minutes="allowedMinutes"
                color="primary"
                flat
                format="24hr"
                min="7:00"
                max="23:00"
                scrollable
                width="270"
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
          </div>
        </v-card-text>
        <v-card-actions>
          <v-btn type="submit" color="base" outlined>更新</v-btn>
        </v-card-actions>
      </v-form>
    </validation-observer>
  </v-card>
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
      railsErrors: {
        show: false,
        message: '',
        errorMessages: [],
      },
    }
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
          })
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
    allowedHours: v => v >= 7 && v <= 23,
    allowedMinutes: m => m % 10 === 0,
  }
};
</script>