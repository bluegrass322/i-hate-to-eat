<template>
  <div>
    <v-card id="bmr-form" color="primary" flat tile>
      <validation-observer ref="observer" v-slot="{ handleSubmit }">
        <v-form @submit.prevent="handleSubmit($emit('click'))">
          <div v-if="railsErrors.show">
            <v-alert
              v-for="e in railsErrors.errorMessages"
              :key="e"
              class="text-center"
              dense
              type="error"
            >
              {{ e }}
            </v-alert>
          </div>
          <div class="with-btn">
            <v-radio-group
              v-model="gender"
              label="性別"
              dark
              row
              mandatory
              :disabled="disableGender"
              class="with-btn-input"
            >
              <v-radio color="base" label="女性" value="female" />
              <v-radio color="base" label="男性" value="male" />
            </v-radio-group>
            <v-btn
              v-show="disableGender"
              color="base"
              outlined
              small
              tile
              class="disable-btn"
              @click="changeGender"
            >
              変更
            </v-btn>
          </div>
          <div class="with-btn">
            <v-menu v-model="birthInput" :close-on-content-click="false">
              <template #activator="{ on }">
                <validation-provider
                  v-slot="{ errors }"
                  name="生年月日"
                  rules="required|abailable_age"
                >
                  <v-text-field
                    v-model="birth"
                    :error-messages="errors"
                    color="base"
                    dark
                    label="生年月日"
                    type="date"
                    readonly
                    :disabled="disableBirth"
                    class="with-btn-input"
                    v-on="on"
                  />
                </validation-provider>
              </template>
              <v-date-picker v-model="birth" @input="birthInput = false" />
            </v-menu>
            <v-btn
              v-show="disableBirth"
              color="base"
              outlined
              small
              tile
              class="disable-btn"
              @click="changeBirth"
            >
              変更
            </v-btn>
          </div>
          <validation-provider
            v-slot="{ errors }"
            name="身長"
            rules="required|numeric"
          >
            <v-text-field
              v-model.number="height"
              :error-messages="errors"
              color="base"
              dark
              type="number"
              suffix="cm"
              label="身長"
            />
          </validation-provider>
          <validation-provider
            v-slot="{ errors }"
            name="体重"
            rules="required|numeric"
          >
            <v-text-field
              v-model.number="weight"
              :error-messages="errors"
              color="base"
              dark
              type="number"
              suffix="kg"
              label="体重"
            />
          </validation-provider>
          <div class="result">
            <v-btn type="submit" color="base" outlined tile small class="mt-1"
              >=</v-btn
            >
            <div class="base--text result-text">
              基礎代謝量: <span class="text-h5 result-bmr">{{ bmr }}</span
              >kcal<br />
              <!-- TODO: PFCの内訳は仮置き -->
              <!-- <span class="text-body-2">
                P: {{ amt.protein }}g / F: {{ amt.fat }}g / C:
                {{ amt.carbohydrate }}g
              </span> -->
            </div>
          </div>
        </v-form>
      </validation-observer>
    </v-card>
    <div class="caption">
      <p class="text-caption primary--text">
        BMRの算出には国立健康・栄養研究所の式を採用しています。
      </p>
      <p class="text-caption primary--text">
        日常的に家事・通勤などにおける歩行運動またはスポーツなどの身体活動を行なっている場合は、必要なエネルギー量は多くなります。
      </p>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  data() {
    return {
      railsErrors: {
        show: false,
        message: '',
        errorMessages: [],
      },
      disableGender: true,
      disableBirth: true,
      birthInput: false,
    };
  },
  computed: {
    ...mapGetters('pfcBalance', ['amt']),
    // TODO: 要リファクタリング
    gender: {
      get() {
        return this.$store.state.bmrParams.user.gender;
      },
      set(value) {
        this.$store.commit('bmrParams/updateGender', value);
      },
    },
    birth: {
      get() {
        return this.$store.state.bmrParams.user.birth;
      },
      set(value) {
        this.$store.commit('bmrParams/updateBirth', value);
      },
    },
    height: {
      get() {
        return this.$store.state.bmrParams.user.height;
      },
      set(value) {
        this.$store.commit('bmrParams/updateHeight', value);
      },
    },
    weight: {
      get() {
        return this.$store.state.bmrParams.user.weight;
      },
      set(value) {
        this.$store.commit('bmrParams/updateWeight', value);
      },
    },
    bmr: {
      get() {
        return this.$store.state.bmrParams.bmr;
      },
      set(value) {
        this.$store.commit('bmrParams/updateBmr', value);
      },
    },
  },
  methods: {
    changeGender() {
      this.disableGender = !this.disableGender;
    },
    changeBirth() {
      this.disableBirth = !this.disableBirth;
    },
  },
};
</script>

<style scoped>
#bmr-form {
  padding: 15px 30px;
}

.caption {
  margin: 30px 20px 15px 15px;
}

.disable-btn {
  margin-left: 25px;
}

.result {
  align-items: flex-start;
  display: flex;
  margin-top: 10px;
}

.result-text {
  margin-left: 20px;
  text-align: center;
}

.result-bmr {
  margin: 0 5px;
}

.with-btn {
  align-items: center;
  display: flex;
}
</style>
