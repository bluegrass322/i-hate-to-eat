<template>
  <div id="bmr-form">
    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit($emit('click'))">
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

        <v-radio-group
          v-model="gender"
          label="性別"
          dark
          row
          mandatory
          hide-details
          class="form-item raido-btn-outline pl-3 py-1 mb-7"
        >
          <v-radio
            color="base"
            label="女性"
            value="female"
            class="radio-btn ma-1"
          />
          <v-radio
            color="base"
            label="男性"
            value="male"
            class="radio-btn ma-1"
          />
        </v-radio-group>
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
                dark
                dense
                label="生年月日"
                type="date"
                readonly
                outlined
                single-line
                class="form-item mb-1"
                v-on="on"
              />
            </validation-provider>
          </template>
          <v-date-picker
            v-model="birth"
            color="primary"
            @input="birthInput = false"
          />
        </v-menu>
        <validation-provider
          v-slot="{ errors }"
          name="身長"
          rules="required|numeric|max_value:200|min_value:0"
        >
          <v-text-field
            v-model.number="height"
            :error-messages="errors"
            dark
            dense
            label="身長"
            max="200"
            min="0"
            outlined
            single-line
            type="number"
            suffix="cm"
            class="form-item mb-1"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="体重"
          rules="required|numeric|max_value:100|min_value:0"
        >
          <v-text-field
            v-model.number="weight"
            :error-messages="errors"
            dark
            dense
            label="体重"
            max="100"
            min="0"
            type="number"
            outlined
            single-line
            suffix="kg"
            class="form-item mb-1"
          />
        </validation-provider>

        <div class="result d-flex align-center mx-auto pa-0">
          <v-btn
            type="submit"
            color="accent"
            depressed
            height="40"
            max-width="90"
            outlined
            tile
            small
            class="resut-btn text-h6 ma-0 px-1 pb-1 flex-grow-1 flex-shrink-0"
          >
            =
          </v-btn>
          <div
            class="result-text accent--text ma-0 py-1 flex-grow-1 flex-shrink-0"
          >
            <span class="text-h6">
              {{ bmr }}
            </span>
            <span class="text-body-2"> kcal/日 </span>
            <!-- TODO: PFCの内訳は仮置き -->
            <!-- <span class="text-body-2">
              P: {{ amt.protein }}g / F: {{ amt.fat }}g / C:
              {{ amt.carbohydrate }}g
            </span> -->
          </div>
        </div>

        <div class="captions text-caption accent--text mt-6">
          <p>※ 国立健康・栄養研究所の式を採用し算出。</p>
          <p>
            ※
            日常的に家事・通勤などでの歩行運動やスポーツなどの身体活動を行なっている場合は、必要なエネルギー量は多くなります。
          </p>
        </div>
      </v-form>
    </validation-observer>
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
};
</script>

<style scoped>
.form-group {
  text-align: center;
}

.v-text-field {
  max-width: 350px;
  padding: 0;
}

.v-input.form-item {
  margin: 0 auto;
}

.v-btn.resut-btn {
  background-color: rgb(44, 76, 107);
  border: 2px solid rgba(245, 245, 246, 0.6);
  box-sizing: border-box;
}

.raido-btn-outline {
  border: 1.5px solid rgb(245, 245, 246);
  max-width: 350px;
  height: 40px;
}

.result {
  max-width: 350px;
}

.result-text {
  border-top: 1px solid rgb(245, 245, 246);
  border-bottom: 1px solid rgb(245, 245, 246);
  border-right: 1px solid rgb(245, 245, 246);
  text-align: center;
  min-width: 150px;
  height: 40px;
}

.captions {
  margin: 0 auto;
  max-width: 350px;
  text-align: start;
  /* 2行目以降を1字下げ */
  padding-left: 1rem;
  text-indent: -1rem;
}

/* outlinedの場合 */
.v-text-field.form-item >>> .v-input__slot {
  border-radius: 0;
  border: 1px solid rgb(245, 245, 246);
}
</style>
