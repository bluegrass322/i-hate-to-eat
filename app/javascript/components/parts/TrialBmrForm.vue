<template>
  <div id="bmr-form">
    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(submit)">
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
          class="form-item raido-btn-outline pl-5 py-1 mb-3"
        >
          <v-radio
            color="accent"
            label="女性"
            value="female"
            class="radio-btn ma-1"
          />
          <v-radio
            color="accent"
            label="男性"
            value="male"
            class="radio-btn ma-1"
          />
        </v-radio-group>
        <v-radio-group
          v-model="age"
          label="年齢"
          dark
          row
          mandatory
          hide-details
          class="form-item raido-btn-outline gender pl-5 py-1 mb-7"
        >
          <div class="d-flex flex-column">
            <v-radio
              color="accent"
              label="18歳~20代"
              value="20"
              class="radio-btn ma-1"
            />
            <v-radio
              color="accent"
              label="30~40代"
              value="30"
              class="radio-btn ma-1"
            />
            <v-radio
              color="accent"
              label="50代~64歳"
              value="50"
              class="radio-btn ma-1"
            />
          </div>
        </v-radio-group>

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
          </div>
        </div>

        <div class="captions text-caption accent--text mt-6">
          <p>
            ※
            厚生労働省制定「日本人の食事摂取基準（2020年版）」参考におおよその値を算出。
          </p>
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
export default {
  data() {
    return {
      railsErrors: {
        show: false,
        message: null,
        errorMessages: null,
      },
      age: null,
      gender: null,
    };
  },
  computed: {
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
    submit() {
      this.$emit('click', this.age, this.gender);
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
  border: 1px solid rgb(245, 245, 246);
  box-sizing: border-box;
}

.raido-btn-outline {
  border: 1.5px solid rgb(245, 245, 246);
  max-width: 350px;
  height: 40px;
}

.raido-btn-outline.gender {
  height: 100%;
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

/* スイッチのラベル */
.v-input--radio-group >>> .v-label {
  margin-right: 20px;
}
</style>
